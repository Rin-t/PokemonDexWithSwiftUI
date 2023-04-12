//
//  Array+.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/12.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
