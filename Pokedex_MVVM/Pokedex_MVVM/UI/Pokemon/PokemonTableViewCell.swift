//
//  PokemonTableViewCell.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: ServiceRequestingImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    // viewModel
    var viewModel: PokemonTableViewCellViewModel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
        pokemonNameLabel.text = nil
        pokemonIDLabel.text = nil
    }
    private func fetchImage(with spritePath:String) {
        guard let imageURL = URL(string: spritePath) else {return}
        pokemonImageView.fetchImage(using: imageURL)
    }
}

extension PokemonTableViewCell: PokemonTableViewCellViewModelDelegate {
    func configure(with pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = "No: \(pokemon.id)"
        fetchImage(with: pokemon.sprites.frontShiny)
    }
}
