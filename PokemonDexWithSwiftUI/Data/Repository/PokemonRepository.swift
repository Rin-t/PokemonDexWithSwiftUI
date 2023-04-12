//
//  PokemonRepository.swift
//  PokemonDexWithSwiftUI
//
//  Created by Rin on 2023/04/12.
//

import Foundation


protocol PokemonRepositoryProtocol {
    func fetchPokemonList(from startId: PokemonId, to endId: PokemonId) async throws -> [PokemonModel]
    func fetchPokemon(id: PokemonId) async throws -> PokemonModel
}

final class PokemonRepository: PokemonRepositoryProtocol {

    private let dataStore: PokemonDataSourceProtocol

    init(dataStore: PokemonDataSourceProtocol = PokemonDataSource()) {
        self.dataStore = dataStore
    }

    func fetchPokemonList(from startId: PokemonId, to endId: PokemonId) async throws -> [PokemonModel] {
        do {
            let data = try await dataStore.fetchPokemonList(from: startId, to: endId)
            return data.map { PokemonModel(entity: $0) }
        } catch {
            throw error
        }
    }

    func fetchPokemon(id: PokemonId) async throws -> PokemonModel {
        do {
            let data = try await dataStore.fetchPokemon(id: id)
            return PokemonModel(entity: data)
        } catch {
            throw error
        }
    }
}

private extension PokemonModel {

    init(entity: PokemonEntity) {
        let type1 = PokemonType(rawValue: entity.types[0].type.name) ?? .unknown
        let hasType2 = entity.types[safe: 1]?.type.name != nil
        var type2: PokemonType?
        if hasType2 {
            type2 = PokemonType(rawValue: entity.types[safe: 1]!.type.name)
        }
        self = .init(name: entity.name,
                     id: entity.id,
                     frontImage: entity.images.frontImage,
                     shinyImage: entity.images.shinyImage,
                     type1: type1,
                     type2: type2)
    }
}
