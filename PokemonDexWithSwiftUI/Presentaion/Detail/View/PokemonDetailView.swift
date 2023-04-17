//
//  PokemonDetailView.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/16.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel

    init(pokemon: PokemonModel) {
        self.viewModel = PokemonDetailViewModel(pokemon: pokemon)
    }

    var body: some View {
        VStack {
            Spacer()
            Spacer()

            Text("No. " + String(viewModel.pokemon.id))
                .font(.system(size: 24, weight: .bold, design: .rounded))

            AsyncImage(url: viewModel.selectedImageUrl) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 240, height: 240)

            Text(viewModel.pokemon.name)
                .font(.system(size: 24, weight: .bold, design: .rounded))

            Spacer()

            HStack(spacing: 36) {
                Button(action: {
                    viewModel.tappedNormalButton()
                }) {
                    Text("normal")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(Color.cyan))
                }

                Button(action: {
                    viewModel.tappedShinyButton()
                }) {
                    Text("shiny")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(Color.cyan))
                }
            }

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

