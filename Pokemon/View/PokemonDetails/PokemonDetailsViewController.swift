//
//  PokemonDetailsViewController.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import UIKit
import Kingfisher

protocol PokemonDetailsView: AnyObject {
    func updateView(pokemonDetals: PokemonDetails)
}

class PokemonDetailsViewController: UIViewController {
    
    var viewModel: PokemonDetailsViewModel!
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        viewModel.getData()
    }
    
    func setupView() {
        view.addSubview(imageView)
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 30).isActive = true
        
        view.addSubview(statsStackView)
        NSLayoutConstraint(item: statsStackView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: statsStackView, attribute: .left, relatedBy: .equal, toItem: imageView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: statsStackView, attribute: .right, relatedBy: .equal, toItem: imageView, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
    
    func getStatView(stat: PokemonDetailStat) -> UIStackView {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.4, blue: 0.4745098039, alpha: 1)
        nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        nameLabel.numberOfLines = 0
        nameLabel.text = "\(stat.name):"
        let valueLabel = UILabel()
        valueLabel.font = UIFont.boldSystemFont(ofSize: 14)
        valueLabel.textColor = #colorLiteral(red: 0.8925139308, green: 0.2164816856, blue: 0.303650856, alpha: 1)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        valueLabel.textAlignment = .right
        valueLabel.text =  String(stat.value)
        let stackView = UIStackView(arrangedSubviews: [nameLabel,valueLabel])
        stackView.spacing = 9
        return stackView
    }
    
    func configureStatsStackView(with stats: [PokemonDetailStat]) {
        stats.forEach {
            let view = getStatView(stat: $0)
            statsStackView.addArrangedSubview(view)
        }
    }
}

extension PokemonDetailsViewController: PokemonDetailsView {
    
    func updateView(pokemonDetals: PokemonDetails) {
        self.title = pokemonDetals.name
        configureStatsStackView(with: pokemonDetals.stats)
        let url = URL(string: pokemonDetals.imageURLStr)
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
    }
    
}
