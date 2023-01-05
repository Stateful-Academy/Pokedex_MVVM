//
//  PokemonViewModel.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

struct PokemonDetailViewModel {
   
    var pokemon: Pokemon
    var spriteImage: UIImage?
    
    // Dependency Injection
    init(pokemon: Pokemon, image: UIImage?) {
        self.pokemon = pokemon
        self.spriteImage = image
    }
}
