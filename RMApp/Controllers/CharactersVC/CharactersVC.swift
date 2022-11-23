//  RMApp
//
//  Created by macbook pro on 2022-11-21.
//

import UIKit

class CharactersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var characterModelview = CharacterModelView()
    var characters: [CharacterModel]?
    var filteredCharacters: [CharacterModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func getCharacters() {
        characterModelview.getAllCharacters { result in
            self.characters = result.results
            self.filteredCharacters = self.characters
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureUI() {
        self.title = "Rick and Morty"
        tableView.register(UINib.init(nibName: CharacterTVC.className, bundle: nil), forCellReuseIdentifier: CharacterTVC.className)
    }

}

extension CharactersVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTVC.className, for: indexPath) as? CharacterTVC
        {
            if let character = filteredCharacters?[indexPath.row] {
                cell.configure(character: character)
            }
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailsVC") as? CharacterDetailsVC {
            vc.character = filteredCharacters?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.bounds.size.height
        return height * 0.15
    }
}

extension CharactersVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharacters = searchText.isEmpty ? characters : characters?.filter { (character: CharacterModel) -> Bool in
            return character.name.lowercased().contains(searchText.lowercased())
        }
        self.tableView.reloadData()
    }
    
}
