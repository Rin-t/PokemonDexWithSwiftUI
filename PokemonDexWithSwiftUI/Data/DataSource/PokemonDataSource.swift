//
//  PokemonDataSource.swift
//  PokeDex
//
//  Created by Rin on 2023/02/25.
//

import Foundation

struct PokemonId {
    private let minimumId = 1
    private let maximumId = 151

    let value: Int

    init(value: Int) {

        if minimumId <= value {
            fatalError("startIdは1以上の値を入力すること")
        }

        if value <= maximumId {
            fatalError("endIdは151よりも小さい値を入力すること")
        }

        self.value = value
    }
}

protocol PokemonDataSourceProtocol {
    func fetchPokemonList(from startId: PokemonId, to endId: PokemonId) async throws -> [PokemonEntity]
    func fetchPokemon(id: PokemonId) async throws -> PokemonEntity
}


final class PokemonDataSource: PokemonDataSourceProtocol {

    //MARK: - Error
    enum Error: Swift.Error {
        case failToFetchData
        case failToCreateUrl
    }

    //MARK: - EndPoint
    private let endPoint = "https://pokeapi.co/api/v2/pokemon/"


    //MARK: - Methods
    func fetchPokemonList(from startId: PokemonId, to endId: PokemonId) async throws -> [PokemonEntity] {
        do {
            let urls = createUrls(from: startId.value, to: endId.value)
            var pokemonArray: [PokemonEntity] = []

            try await withThrowingTaskGroup(of: PokemonEntity.self) { group in
                for url in urls {
                    group.addTask {
                        try await self.fetchData(from: url)
                    }
                }

                for try await pokemon in group {
                    pokemonArray.append(pokemon)
                }
            }
            return pokemonArray
        } catch {
            throw Error.failToFetchData
        }
    }

    func fetchPokemon(id: PokemonId) async throws -> PokemonEntity {
        do {
            let url = createUrl(id: id.value)
            let pokemon = try await fetchData(from: url)
            return pokemon
        } catch {
            throw Error.failToFetchData
        }
    }

    private func fetchData(from url: URL) async throws -> PokemonEntity {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = try JSONDecoder().decode(PokemonEntity.self, from: data)
        return decoder
    }

    private func createUrls(from startId: Int, to endId: Int) -> [URL] {
        var urls: [URL] = []
        for i in startId...endId {
            let url = URL(string: endPoint + String(i))!
            urls.append(url)
        }
        return urls
    }

    private func createUrl(id: Int) -> URL {
        let url = URL(string: endPoint + String(id))!
        return url
    }
}
