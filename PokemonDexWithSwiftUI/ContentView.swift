//
//  ContentView.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/10.
//

import SwiftUI

// 使い回しを考えるなら型として持つべきか。
private let cellSpacing: CGFloat = 16.0
private let cellNumberInColumn: CGFloat = 2
private let spacingNumber: CGFloat = cellNumberInColumn + 1
private let spacingTotal = cellSpacing * spacingNumber

struct ContentView: View {
    let columns = [GridItem(.flexible(), spacing: cellSpacing)
                   ,GridItem(.flexible())]

    #warning("ViewModelTypeにしてDIしたかった。")
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        GeometryReader { geometry in
            let cellWidth = (geometry.size.width - spacingTotal) / cellNumberInColumn

            ScrollView() {
                LazyVGrid(columns: columns, spacing: cellSpacing) {
                    ForEach(0..<viewModel.pokemons.count, id: \.self) { index in
                        MonsterBallView(cellWidth: cellWidth, pokemon: $viewModel.pokemons[index])
                    }
                }
                .padding(.horizontal, cellSpacing)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HomeViewModel())
    }
}
