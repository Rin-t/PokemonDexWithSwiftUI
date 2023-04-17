//
//  PoekemonDetailViewModel.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/17.
//

import SwiftUI

final class PokemonDetailViewModel: ObservableObject {

    @Published var pokemon: PokemonModel
    @Published var selectedImageUrl: URL!

    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
        self.selectedImageUrl = URL(string: pokemon.frontImage)!
    }

    func tappedNormalButton() {
        selectedImageUrl = URL(string: pokemon.frontImage)!
    }

    func tappedShinyButton() {
        selectedImageUrl = URL(string: pokemon.shinyImage)!
    }
}
