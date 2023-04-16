//
//  MonsterBallView.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/16.
//

import SwiftUI

struct MonsterBallView: View {

    private let cellWidth: CGFloat
    private let pokemon: PokemonModel

    init(cellWidth: CGFloat, pokemon: PokemonModel) {
        self.cellWidth = cellWidth
        self.pokemon = pokemon
    }

    var body: some View {
        ZStack {
            // モンスターボールの表示
            Text("")
                .padding()
                .frame(width: cellWidth, height: cellWidth)
                .background(
                    ZStack {
                        Circle()
                            .fill(Color(red: 1, green: 0.6, blue: 0.6))
                            .frame(height: cellWidth)
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: cellWidth / 2)
                            .offset(y: cellWidth / 4)
                    }
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                )

            VStack(spacing: 0) {
                // idの表示
                Text("No. " + String(pokemon.id))

                // 画像の表示
                let url = URL(string: pokemon.frontImage)!
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: cellWidth / 2, height: cellWidth / 2)

                // 名前の表示
                Text(pokemon.name)
            }
        }
    }
}

struct MonsterBallView_Previews: PreviewProvider {

    static let frontImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    static let shinyImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png"
    static let pokemon = PokemonModel(name: "pikachu",
                                              id: 25,
                                              frontImage: frontImage,
                                              shinyImage: shinyImage,
                                              type1: .electric,
                                              type2: nil)
    static var previews: some View {
        MonsterBallView(cellWidth: 200, pokemon: pokemon)
    }
}
