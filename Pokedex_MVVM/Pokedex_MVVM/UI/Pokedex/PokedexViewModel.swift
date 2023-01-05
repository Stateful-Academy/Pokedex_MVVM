//
//  PokedexViewModel.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import Foundation

protocol PokedexTableviewDelegate: PokedexTableViewController {
    func pokedexResultsLoadedSuccessfully()
    func encountered(_ error: Error)
}

class PokedexViewModel {
    
    private let pokedexService: PokedexServiceable
    var pokedex: Pokedex?
    var pokedexResults: [PokemonResults] = []
    weak var delegate: PokedexTableviewDelegate?
    
    // Depencey Injection
    init(delegate: PokedexTableviewDelegate, pokedexService: PokedexServiceable = PokedexService()) {
        self.delegate = delegate
        self.pokedexService = pokedexService
        loadPokedexResults()
    }
    
    func loadPokedexResults() {
        pokedexService.fetch(from:.pokedex) { [weak self] result in
            self?.handle(pokedex: result)
        }
    }
    
    func nextPage() {
        guard let pokedex = pokedex,
        let nextURL = URL(string: pokedex.next) else { return}

        pokedexService.fetch(from: .nextPage(nextURL)) { [weak self] result in
            self?.handle(pokedex: result)
        }
    }
    
    private func handle(pokedex result: Result<Pokedex, NetworkError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let pokedex):
                self.pokedex = pokedex
                self.pokedexResults.append(contentsOf: pokedex.results)
                self.delegate?.pokedexResultsLoadedSuccessfully()
            case .failure(let error):
                print("Error fetching the data!", error.localizedDescription)
                self.delegate?.encountered(error)
            }
        }
    }
}
