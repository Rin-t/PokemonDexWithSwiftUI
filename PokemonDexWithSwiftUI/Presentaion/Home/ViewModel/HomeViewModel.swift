//
//  HomeViewModel.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/11.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {

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
