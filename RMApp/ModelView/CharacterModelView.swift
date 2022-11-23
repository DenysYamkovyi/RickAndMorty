
//  RMApp
//
//  Created by macbook pro on 2022-11-21.
//

import Foundation

public struct CharacterModelView {
    
    var networkService: NetworkService = NetworkService()
    
    mutating func getAllCharacters(completion: @escaping (CharacterInfoModel) -> Void) {
        networkService.dataRequest(with: .characters, objectType: CharacterInfoModel.self) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
                completion(object)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
