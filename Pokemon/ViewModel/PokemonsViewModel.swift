//
//  PokemonsViewModel.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import Foundation

protocol PokemonsViewModel {
    func fetchPokemons()
    func getPokemonsCount() -> Int
    func getPokemon(for index: Int) -> Pokemon
    func didScrollToBottom()
    func didSelectRow(at index: Int)
}

class PokemonsViewModelImpl {
    
    weak var view: PokemonsView?

    var pokemons: [Pokemon] = []
    var offset: Int { pokemons.count }
    var isLoading = false
    var pokemonDetailEntities: [String : PokemonDetailsEntity] = [:]
    
    func fetchPokemons() {
        API.shared.fetchPokemons(limit: 40, offset: offset) { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let entity):
                    self?.handlePokemonsResponse(entity)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func fetchImage(name: String, index: Int) {
        API.shared.fetchPokemonDetails(name: name) { [weak self] result in
            switch result {
            case .success(let entity):
                self?.pokemonDetailEntities[name] = entity
                self?.pokemons[index].imageURLStr = entity.sprites.other.home.frontDefault
                self?.view?.reloadRow(at: index)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func handlePokemonsResponse(_ entity: PokemonsResponseEntity) {
        self.pokemons += entity.results.enumerated().map {
            fetchImage(name: $1.name, index: $0 + offset)
            return .init(name: $1.name, imageURLStr: "")
        }
        self.view?.reloadData()
    }
    
    func didScrollToBottom() {
        if !isLoading {
            isLoading = true
            fetchPokemons()
        }
    }
}

extension PokemonsViewModelImpl: PokemonsViewModel {
    
    func didSelectRow(at index: Int) {
        let pokemon = pokemons[index]
        guard let details = pokemonDetailEntities[pokemon.name] else { return }
        let detailsVC = PokemonDetailsViewController()
        let detailsVM = PokemonDetailsViewModelImpl(details: details)
        detailsVC.viewModel = detailsVM
        detailsVM.view = detailsVC
        view?.showVC(vc: detailsVC)
    }
    
    func getPokemonsCount() -> Int {
        pokemons.count
    }
    
    func getPokemon(for index: Int) -> Pokemon {
        pokemons[index]
    }
}
