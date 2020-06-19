//
//  PokemonController.swift
//  MJPPokedex
//
//  Created by Mark Poggi on 6/19/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import Foundation
import UIKit

@objc(MJPPokemonController)

class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc (sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping ([MJPPokemon]?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil, NSError())
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                guard let results = jsonDictionary["results"] as? [[String: Any]] else { throw NSError() }
                let allPokemon = results.map({ MJPPokemon(dictionary: $0) })
                completion(allPokemon, nil)
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return completion(nil, NSError())
            }
        }
        dataTask.resume()
    }
    
    @objc func fillInDetails(for pokemon: MJPPokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            do {
                guard let jsonDictionary =
                    try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                let detailPokemon = MJPPokemon(dictionary: jsonDictionary)
                pokemon.name = detailPokemon.name
                pokemon.sprite = detailPokemon.sprite
                pokemon.identifier = detailPokemon.identifier
                pokemon.abilities = detailPokemon.abilities
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return
            }
        }
        dataTask.resume()
        
    }
}

