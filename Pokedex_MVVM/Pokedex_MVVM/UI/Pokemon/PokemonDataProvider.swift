//
//  PokemonDataProvider.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 10/19/22.
//

import Foundation

protocol PokemonServiceable {
    func fetch(from endpoint: PokemonEndpoint, completion: @escaping (Result<Pokemon, NetworkError>)-> Void)
}
struct PokemonService: PokemonServiceable {
    private let service = APIService()
    func fetch(from endpoint: PokemonEndpoint, completion: @escaping (Result<Pokemon, NetworkError>)-> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.badURL(endpoint.url))); return }
        
        let request = URLRequest(url: url)
        
        service.perform(request) { result in
            switch result {
            case.success(let data):
                do {
                    let pokemon = try data.decode(type: Pokemon.self)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case.failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
}
