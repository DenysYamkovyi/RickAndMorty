//
//  CharacterModel.swift
//  RMApp
//
//  Created by macbook pro on 2022-11-21.
//

import Foundation
 
struct CharacterInfoModel: Codable {
    let info: Info
    let results: [CharacterModel]
}

public struct CharacterModel: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let location: CharacterLocationModel
    public let image: String
    public let episode: [String]
}

public struct CharacterLocationModel: Codable {
    public let name: String
    public let url: String
}
