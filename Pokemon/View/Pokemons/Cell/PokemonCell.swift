//
//  PokemonCell.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import UIKit
import Kingfisher

class PokemonCell: UITableViewCell {
    
    func configure(with pokemon: Pokemon) {
        textLabel?.text = pokemon.name
        let url = URL(string: pokemon.imageURLStr)
        imageView?.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
    }
}
