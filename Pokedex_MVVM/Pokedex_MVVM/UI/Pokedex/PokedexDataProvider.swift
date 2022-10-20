//
//  PokedexDataProvider.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import Foundation

protocol PokedexServiceable {
    func fetch(from endpoint: PokemonEndpoint, completion: @escaping (Result<Pokedex, NetworkError>)-> Void)
}

struct PokedexService: PokedexServiceable {
    private let service = APIService()
    func fetch(from endpoint: PokemonEndpoint, completion: @escaping (Result<Pokedex, NetworkError>)-> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.badURL(endpoint.url)))
            return
        }
        let request = URLRequest(url: url)
        
        service.perform(request) { result in
            switch result {
            case.success(let data):
                do {
                    let pokedex = try data.decode(type: Pokedex.self)
                    completion(.success(pokedex))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case.failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
}

