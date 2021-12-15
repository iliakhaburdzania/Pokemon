//
//  PokemonsResponseEntity.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import Foundation

struct PokemonsResponseEntity: Decodable {
    let results: [PokemonEntity]
}
