//
//  API.swift
//  Pokemons
//
//  Created by Ilia Khaburdzania on 15.12.21.
//

import Foundation

class API {
    
    static var shared = API()
    
    private init() { }
    
    func fetchPokemons(limit: Int, offset: Int, completionHandler: @escaping (Result<PokemonsResponseEntity, Error>) -> Void) {
        let urlStr = Constants.API.baseUrlStr + Constants.API.Routes.pokemon
        let queryItems: [URLQueryItem] = [.init(name: Constants.API.Queries.limit, value: limit.description),
                                          .init(name: Constants.API.Queries.offset, value: offset.description)]
        fetch(urlStr: urlStr, queryItems: queryItems, completionHandler: completionHandler)
    }
    
    func fetchPokemonDetails(name: String, completionHandler: @escaping (Result<PokemonDetailsEntity, Error>) -> Void) {
        let urlStr = Constants.API.baseUrlStr + Constants.API.Routes.pokemon + "/\(name)"
        fetch(urlStr: urlStr, completionHandler: completionHandler)
    }
    
    private func fetch<Entity: Decodable>(urlStr: String, queryItems: [URLQueryItem]? = nil, completionHandler: @escaping (Result<Entity, Error>) -> Void) {
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(DefaultApiError()))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completionHandler(.failure(DefaultApiError()))
            return
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completionHandler(.failure(DefaultApiError()))
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let entity = try JSONDecoder().decode(Entity.self, from: data)
                    completionHandler(.success(entity))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
}

struct DefaultApiError: Error {
    let localizedDescription = "something went wrong"
}
