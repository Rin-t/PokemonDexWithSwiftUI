//
//  PokemonImageEntity.swift
//  PokeDex
//
//  Created by Rin on 2023/02/25.
//

import Foundation

struct PokemonImageEntity: Decodable {
    let frontImage: String
    let shinyImage: String

    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
        case shinyImage = "front_shiny"
    }
}
