//
//  PokemonEndpoint.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import Foundation


extension URL {
    static let pokemonBaseURL = URL(string:"https://pokeapi.co/api/v2/")
}

enum PokemonEndpoint {

    case pokemon(String)
    case pokedex
    case nextPage(URL)
    
    var url: URL? {
        guard var baseURL = URL.pokemonBaseURL else {return nil}
        baseURL.appendPathComponent("pokemon")
        
        switch self {
        case .pokedex:
            return baseURL
        case .pokemon(let pokemon):
            baseURL.appendPathComponent(pokemon)
            return baseURL
        case .nextPage(let nextURL):
            return nextURL
        }
    }
}
