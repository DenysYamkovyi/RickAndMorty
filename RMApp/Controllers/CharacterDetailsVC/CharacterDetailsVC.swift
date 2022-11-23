//
//  CharacterDetailsVC.swift
//  RMApp
//
//  Created by macbook pro on 2022-11-22.
//

import UIKit

class CharacterDetailsVC: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareThumbnail()
    }
    
    func prepareUI() {
        name.text = character?.name
        status.text = character?.status
        species.text = character?.species
        gender.text = character?.gender
        location.text = character?.location.name
        
        characterImage.image = UIImage.init(systemName: "person.circle")
        if let url = URL(string: character?.image ?? "") {
            characterImage.downloaded(from: url)
        }
    }
    
    func prepareThumbnail() {
        characterImage.layer.cornerRadius = 5
        characterImage.layer.masksToBounds = true
    }
}
