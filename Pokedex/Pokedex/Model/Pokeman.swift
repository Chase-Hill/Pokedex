//
//  Pokeman.swift
//  Pokedex
//
//  Created by Chase on 2/23/23.
//

import Foundation

class Pokeman {
    
    let name: String
    let id: Int
    let moves: String
    let spritePath: String
    
    enum Keys: String {
        case name
        case id
        case moves
        case spritePath = "sprites"
    }
    
    init?(dictionary: [String : Any]) {
        guard let name = dictionary[Keys.name.rawValue] as? String,
              let id = dictionary[Keys.id.rawValue] as? Int,
              let moves = dictionary[Keys.moves.rawValue] as? String,
              let spritePath = dictionary[Keys.spritePath.rawValue] as? String else {
                  print("You're A Failure At Exactly: \(#file)\(#line)")
                  return nil
              }
        
        self.name = name
        self.id = id
        self.moves = moves
        self.spritePath = spritePath
    }
}
