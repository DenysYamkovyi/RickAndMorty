//  RMApp
//
//  Created by macbook pro on 2022-11-21.
//

import UIKit

class CharacterTVC: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var episodesCount: UILabel!
    
    func configure(character: CharacterModel) {
        
        setAvatar(avatarUrl: character.image)
        characterName.text = character.name
        
        episodesCount.text = "\(character.episode.count) Episode(s)"
        
        prepareThumbnail()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    internal func setAvatar(avatarUrl: String)
    {
        thumbnail.image = UIImage.init(systemName: "person.circle")
        if let url = URL(string: avatarUrl) {
            thumbnail.downloaded(from: url)
        }
    }
    
    func prepareThumbnail() {
        
        thumbnail.layer.cornerRadius = 5
        thumbnail.layer.masksToBounds = true
    }
}
