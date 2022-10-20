//
//  PokemonViewController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    var viewModel: PokemonDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.delegate = self
        pokemonMovesTableView.dataSource = self
        configure()
    }
    
    func configure() {
        if let sprite = viewModel.spriteImage {
            pokemonSpriteImageView.image = sprite
        }
        self.pokemonNameLabel.text = viewModel.pokemon.name.capitalized
        self.pokemonIDLabel.text = "No: \(viewModel.pokemon.id)"
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Moves"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemon.moves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        let move = viewModel.pokemon.moves[indexPath.row].move.name
        cell.textLabel?.text = move
        return cell
    }
} 
