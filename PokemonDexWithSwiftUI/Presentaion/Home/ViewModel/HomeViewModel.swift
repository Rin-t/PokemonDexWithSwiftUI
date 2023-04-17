//
//  HomeViewModel.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/11.
//

import Foundation
import SwiftUI

#warning("ViewModelTypeをHomeViewのpropertyで持とうとしたらできなかった")
protocol HomeViewModelInput {
    func onAppear()
    func tappeGrid(index: Int)
}

protocol HomeViewModelOutput {
    var isPresentDetailVC: Bool { get }
    var isShowingFailToPokemonAlert: Bool { get }
    var pokemon: PokemonModel? { get }
    var pokemons: [PokemonModel] { get }
}

protocol HomeViewModelType: ObservableObject {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

final class HomeViewModel: ObservableObject, HomeViewModelInput, HomeViewModelOutput {

    @Published var isShowingFailToPokemonAlert: Bool = false
    @Published var pokemons: [PokemonModel] = []
    @Published var pokemon: PokemonModel?

    private let useCase: PokemonUseCaseProtocol

    init(useCase: PokemonUseCaseProtocol = PokemonUseCase()) {
        self.useCase = useCase
    }

    @MainActor
    func onAppear() {
        Task {
            do {
                let startSearchId = PokemonId(value: 1)
                let endSearchId = PokemonId(value: 151)
                pokemons = try await useCase.fetchPokemonList(from: startSearchId, to: endSearchId)
            } catch {
                isShowingFailToPokemonAlert = true
            }
        }
    }
}


extension HomeViewModel: HomeViewModelType {

    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}
