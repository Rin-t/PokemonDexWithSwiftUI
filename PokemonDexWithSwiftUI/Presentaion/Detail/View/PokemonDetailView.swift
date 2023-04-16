//
//  PokemonDetailView.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/16.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: PokemonModel

    var body: some View {
        VStack {
            Spacer()
            Text("No. " + String(pokemon.id))
                .font(.system(size: 24, weight: .bold, design: .rounded))

            let url = URL(string: pokemon.frontImage)!
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 240, height: 240)

            Text(pokemon.name)
                .font(.system(size: 24, weight: .bold, design: .rounded))

            Spacer()
        }
    }
}


struct PokemonDetailView_Previews: PreviewProvider {

    static var previews: some View {
        PokemonDetailViewWrapper()
    }
}

struct PokemonDetailViewWrapper: View {
    static let frontImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    static let shinyImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png"
    @State private var pokemon = PokemonModel(name: "pikachu",
                                              id: 25,
                                              frontImage: frontImage,
                                              shinyImage: shinyImage,
                                              type1: .electric,
                                              type2: nil)

    var body: some View {
        PokemonDetailView(pokemon: pokemon)
    }
}

