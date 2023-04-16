//
//  ContentView.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/10.
//

import SwiftUI

private let cellSpacing: CGFloat = 16.0
private let cellNumberInColumn: CGFloat = 2
private let spacingNumber: CGFloat = cellNumberInColumn + 1
private let spacingTotal = cellSpacing * spacingNumber

struct ContentView: View {
    let columns = [GridItem(.flexible(), spacing: cellSpacing)
                   ,GridItem(.flexible())]

    var body: some View {
        GeometryReader { geometry in
            let cellWidth = (geometry.size.width - spacingTotal) / cellNumberInColumn

            ScrollView() {
                LazyVGrid(columns: columns, spacing: cellSpacing) {
                    ForEach((1...50), id: \.self) { num in
                        Text("\(num)")
                            .padding()
                            .frame(width: cellWidth, height: cellWidth)
                            .background(
                                ZStack {
                                    Circle()
                                        .fill(Color.red)
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
                    }
                }
                .padding(.horizontal, cellSpacing)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
