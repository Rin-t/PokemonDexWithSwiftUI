//
//  HomeView.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/10.
//

import SwiftUI

#warning("型として定義して使いまわせるようにしたいできるか？")
private let cellSpacing: CGFloat = 16.0
private let cellNumberInColumn: CGFloat = 2
private let spacingNumber: CGFloat = cellNumberInColumn + 1
private let spacingTotal = cellSpacing * spacingNumber

struct HomeView: View {
    let columns = [GridItem(.flexible(), spacing: cellSpacing)
                   ,GridItem(.flexible())]

    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        GeometryReader { geometry in
            let cellWidth = (geometry.size.width - spacingTotal) / cellNumberInColumn
            NavigationStack {
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
                .navigationTitle("Pokemon Dex")
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .alert(
            viewModel.alertContent.title,
            isPresented: $viewModel.isAlertShowing,
            presenting: viewModel.alertContent
        ) { content in
            Button(content.actionText) { }
        } message: { content in
            Text(content.message)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
