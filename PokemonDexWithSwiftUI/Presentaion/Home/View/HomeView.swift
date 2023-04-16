//
//  HomeView.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/10.
//

import SwiftUI

// 型として定義して使いまわせるようにしたい。
private let cellSpacing: CGFloat = 16.0
private let cellNumberInColumn: CGFloat = 2
private let spacingNumber: CGFloat = cellNumberInColumn + 1
private let spacingTotal = cellSpacing * spacingNumber

struct HomeView: View {
    let columns = [GridItem(.flexible(), spacing: cellSpacing)
                   ,GridItem(.flexible())]

    #warning("ViewModelTypeにしてDIしたかった。")
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        GeometryReader { geometry in
            let cellWidth = (geometry.size.width - spacingTotal) / cellNumberInColumn
            NavigationView {
                ScrollView() {
                    LazyVGrid(columns: columns, spacing: cellSpacing) {
                        ForEach(0..<viewModel.pokemons.count, id: \.self) { index in
                            let pokemon = viewModel.pokemons[index]
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                MonsterBallView(cellWidth: cellWidth, pokemon: pokemon)
                            }
                        }
                    }
                    .padding(.horizontal, cellSpacing)
                }
                .navigationTitle("初代ポケモン一覧")
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
