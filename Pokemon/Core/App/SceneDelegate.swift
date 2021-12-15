//
//  SceneDelegate.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        let pokemonsVM = PokemonsViewModelImpl()
        let pokemonsVC = PokemonsViewController(viewModel: pokemonsVM)
        pokemonsVM.view = pokemonsVC
        let pokemonsNC = UINavigationController(rootViewController: pokemonsVC)
        pokemonsNC.navigationBar.prefersLargeTitles = true
        window.rootViewController = pokemonsNC
        self.window = window
        window.makeKeyAndVisible()
    }
}

