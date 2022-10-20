//
//  PokedexTableViewController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokedexViewModel: PokedexViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexViewModel = PokedexViewModel(delegate: self)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexViewModel.pokedexResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        
        cell.viewModel = PokemonTableViewCellViewModel(pokedex: pokedexViewModel.pokedexResults[indexPath.row], delegate: cell)
        
        return cell
    }
    
    //MARK: - Pagination
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let pokedexViewModel = pokedexViewModel,
              let pokedex = pokedexViewModel.pokedex else {return}
        
        let lastPokedexIndex = pokedex.results.count - 1
        
        if indexPath.row == lastPokedexIndex {
            pokedexViewModel.nextPage()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "toPokemonDetails",
                  let destinationVC = segue.destination as? PokemonDetailViewController,
                      let cell = sender as? PokemonTableViewCell,
        let pokemon = cell.viewModel.pokemon else {return}
        let sprite = cell.pokemonImageView.image
        destinationVC.viewModel = PokemonDetailViewModel(pokemon: pokemon, image: sprite)
    }
}
//
//                let pokemonToSend = self.pokedexViewModel.pokedexResults[indexPath.row]
//                destinationVC.viewModel = PokemonDetailViewModel(pokemon: pokemonToSend)
// don't need t fetch we have it. Destination.viewM = cell.view
// pokemonViewModel

//                NetworkingController.fetchPokemon(with: pokemonToSend.url) { result in
//                    switch result {
//                    case .success(let pokemon):
//                        DispatchQueue.main.async {
//                            destinationVC.pokemon = pokemon
//                        }
//                    case .failure(let error):
//                        print("There was an error!", error.errorDescription!)
//                    }
////                }
//            }
//        }


extension PokedexTableViewController: PokedexTableviewDelegate {
    func pokedexResultsLoadedSuccessfully() {
        tableView.reloadData()
    }
    
    func encountered(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            self?.pokedexViewModel?.loadPokedexResults()
        }))
        present(alertController, animated: true)
    }
}
