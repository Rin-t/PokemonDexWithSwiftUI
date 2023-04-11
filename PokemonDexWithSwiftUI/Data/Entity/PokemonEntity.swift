//
//  Pokemon.swift
//  PokeDex
//
//  Created by Rin on 2023/02/25.
//

import Foundation

struct PokemonEntity: Decodable {
    let name: String
    let id: Int
    let images: PokemonImageEntity
    let types: [PokemonTypesEntity]

    enum CodingKeys: String, CodingKey {
        case name
        case id
        case images = "sprites"
        case types
    }
}
