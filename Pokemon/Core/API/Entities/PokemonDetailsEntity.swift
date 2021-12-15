//
//  PokemonDetailsEntity.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import Foundation

struct PokemonDetailsEntity: Decodable {
    let name: String
    let sprites: PokemonDetailsSpritesEntity
    let stats: [PokemonDetailsStatDataEntity]
}

struct PokemonDetailsSpritesEntity: Decodable {
    let other: PokemonDetailsOtherSpritesEntity
}

struct PokemonDetailsOtherSpritesEntity: Decodable {
    let home: PokemonDetailsOtherSpritesHomeEntity
}

struct PokemonDetailsOtherSpritesHomeEntity: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonDetailsStatDataEntity: Decodable {
    let baseStat: Int
    let stat: PokemonDetailsStatEntity
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct PokemonDetailsStatEntity: Decodable {
    let name: String
}
