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
}

protocol HomeViewModelOutput {
    var isAlertShowing: Bool { get }
    var pokemon: PokemonModel? { get }
    var pokemons: [PokemonModel] { get }
}

protocol HomeViewModelType: ObservableObject {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

final class HomeViewModel: ObservableObject, HomeViewModelInput, HomeViewModelOutput {

    @Published var isAlertShowing: Bool = false
    @Published var pokemons: [PokemonModel] = []
    @Published var pokemon: PokemonModel?
    @Published var alertContent = AlertContent(title: "", message: "", actionText: "")

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
            } catch let error as PokemonDataSource.Error {
                let title: String
                switch error {
                case .failToCreateUrl:
                    title = "URLが正しくありません"
                case .failToFetchData:
                    title = "データの取得に失敗しました"
                }
                alertContent = AlertContent(title: title,
                                            message: "",
                                            actionText: "OK")
                isAlertShowing = true
            } catch {
                alertContent = AlertContent(title: "不明なエラーです",
                                            message: "",
                                            actionText: "OK")
                isAlertShowing = true
            }
        }
    }
}


extension HomeViewModel: HomeViewModelType {

    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}
