//
//  PokemonUseCase.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/11.
//

import Foundation

protocol PokemonUseCaseProtocol {
    func fetchPokemonList(from startId: PokemonId, to endId: PokemonId) async throws -> [PokemonModel]
    func fetchPokemon(id: PokemonId) async throws -> PokemonModel
}

final class PokemonUseCase: PokemonUseCaseProtocol {

    private let repository: PokemonRepositoryProtocol

    init(repository: PokemonRepositoryProtocol = PokemonRepository()) {
        self.repository = repository
    }

    func fetchPokemonList(from startId: PokemonId, to endId: PokemonId) async throws -> [PokemonModel] {
        do {
            return try await repository.fetchPokemonList(from: startId, to: endId)
        } catch {
            throw error
        }
    }

    func fetchPokemon(id: PokemonId) async throws -> PokemonModel {
        do {
            return try await repository.fetchPokemon(id: id)
        } catch {
            throw error
        }
    }
}


