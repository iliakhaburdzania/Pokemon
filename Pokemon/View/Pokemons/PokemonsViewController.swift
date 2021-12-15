//
//  ViewController.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import UIKit

protocol PokemonsView: AnyObject {
    func reloadData()
    func reloadRow(at index: Int)
    func showVC(vc: UIViewController)
}

class PokemonsViewController: UITableViewController {
    
    let viewModel: PokemonsViewModel
    
    init(viewModel: PokemonsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        viewModel.fetchPokemons()
    }
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
        self.title = "Pokemons"
    }
    
    func setupTableView() {
        tableView.register(PokemonCell.self, forCellReuseIdentifier: Constants.ReuseIdentifiers.pokemonCell)
    }
}

// MARK: - UITableView data source & delegate

extension PokemonsViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - 100 - scrollView.bounds.size.height {
            viewModel.didScrollToBottom()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getPokemonsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifiers.pokemonCell) as! PokemonCell
        let pokemon = viewModel.getPokemon(for: indexPath.row)
        cell.configure(with: pokemon)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
}

extension PokemonsViewController: PokemonsView {
    
    func showVC(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadRow(at index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    
    func reloadData() {
        tableView.reloadData()
    }
}

