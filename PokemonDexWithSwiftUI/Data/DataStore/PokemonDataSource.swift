//
//  PokemonDataSource.swift
//  PokeDex
//
//  Created by Rin on 2023/02/25.
//

import Foundation

struct SearchPokemonId {
    private let minimumSearchId = 1
    private let maximumSearchId = 151
    let startId: Int
    let endId: Int

    init(startId: Int, endId: Int) {
        self.startId = startId
        self.endId = endId

        if startId < minimumSearchId {
            fatalError("startIdは1以上の値を入力すること")
        }

        if endId > maximumSearchId {
            fatalError("endIdは151よりも小さい値を入力すること")
        }

        if startId > endId {
            fatalError("startIdよりもendId以上に設定すること")
        }
    }
}


final class PokemonDataSource {

    enum Error: Swift.Error {
        case failToFetchData
        case failToCreateUrl
    }

    private let endPoint = "https://pokeapi.co/api/v2/pokemon/"


    func fetchPokemons(from startId: Int, to endId: Int) async throws -> [PokemonEntity] {
        do {
            let urls = createUrls(from: startId, to: endId)
            var pokemons: [PokemonEntity] = []

            try await withThrowingTaskGroup(of: PokemonEntity.self) { group in
                for url in urls {
                    group.addTask {
                        try await self.fetchData(from: url)
                    }
                }

                for try await pokemon in group {
                    pokemons.append(pokemon)
                }
            }
            return pokemons
        } catch {
            throw Error.failToFetchData
        }
    }

    func fetchPokemon(id: Int) async throws -> PokemonEntity {
        do {
            let url = createUrl(id: id)
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
