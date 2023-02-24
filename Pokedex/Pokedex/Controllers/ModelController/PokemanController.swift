//
//  PokemanController.swift
//  Pokedex
//
//  Created by Chase on 2/23/23.
//

import UIKit

class PokemanController {
    
    static func fetchPokeman(searchTerm: String, completion: @escaping (Pokeman?) -> Void) {
        
        guard let baseURL = URL(string: Constants.PokemanURL.baseURL) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(searchTerm.lowercased())
        
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print("Final Pokeman URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Pokeman Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(nil) ; return }
            
            do {
                
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any] {
                    
                    let pokeman = Pokeman(dictionary: topLevel)
                    completion(pokeman)
                }
                
            } catch {
                
                print(error.localizedDescription)
                completion(nil) ; return
            }
        } .resume()
    }
    
    static func fetchImage(forPokeman pokeman: Pokeman, completion: @escaping (UIImage?) -> Void) {
       print("fetching image")
        guard let finalURL = URL(string: pokeman.spritePath) else { completion(nil) ; return }
        print("Final Sprite URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Sprite Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(nil) ; return }
            
            let sprite = UIImage(data: data)
            completion(sprite)
            
        } .resume()
    }
}
