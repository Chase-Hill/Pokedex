//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Karl Pfister on 2/3/22.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.dataSource = self
        pokemonMovesTableView.delegate = self
        pokemonSearchBar.delegate = self
    }
    
    // MARK: - Properties
    var pokemans: Pokeman?
    
    // MARK: - Functions
    func updateViews(forPokeman pokeman: Pokeman) {
        print("updating views")
        PokemanController.fetchImage(forPokeman: pokeman) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.pokemans = pokeman
                self.pokemonIDLabel.text = "ID: \(pokeman.id)"
                self.pokemonNameLabel.text = pokeman.name
                self.pokemonSpriteImageView.image = image
                self.pokemonMovesTableView.reloadData()
            }
        }
    }
} // End of Class

// MARK: - Extensions

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemans?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)

        let move = pokemans?.moves[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = move
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "moves"
    }
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        PokemanController.fetchPokeman(searchTerm: searchTerm) { pokemans in
            guard let pokemans = pokemans else { return }
            self.pokemans = pokemans
            self.updateViews(forPokeman: pokemans)
        }
    }
}
