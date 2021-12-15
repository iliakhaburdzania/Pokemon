//
//  Constants.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import Foundation

struct Constants {
    
    struct API {
        static let baseUrlStr = "https://pokeapi.co/api/v2"
        
        struct Routes {
            static let pokemon = "/pokemon"
        }
        
        struct Queries {
            static let limit = "limit"
            static let offset = "offset"
        }
    }
    
    struct ReuseIdentifiers {
        static let pokemonCell = "PokemonCell"
    }
}
