//
//  PokemonTableViewCellViewModel.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 10/19/22.
//

import Foundation
protocol PokemonTableViewCellViewModelDelegate: AnyObject {
    func configure(with pokemon: Pokemon)
}

class PokemonTableViewCellViewModel {
    private let pokemonService: PokemonServiceable
    var pokemon: Pokemon?
    var pokedex: PokemonResults
    
    weak var delegate: PokemonTableViewCellViewModelDelegate?
    
    // Dependency Injection
    init(pokedex: PokemonResults, delegate: PokemonTableViewCellViewModelDelegate, pokemonService: PokemonServiceable = PokemonService()) {
        self.delegate = delegate
        self.pokedex = pokedex
        self.pokemonService = pokemonService
        fetchPokemon()
    }
    
    func fetchPokemon() {
        pokemonService.fetch(from: .pokemon(pokedex.name)) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.delegate?.configure(with: pokemon)
                }
            case .failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
}
