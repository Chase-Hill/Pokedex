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
    let moves: [String]
    let spritePath: String
    
    enum Keys: String {
        case name
        case id
        case moves
        case spritePath = "sprites"
        case frontShiny = "front_shiny"
        case move
    }
    
    init?(dictionary: [String : Any]) {
        guard let name = dictionary[Keys.name.rawValue] as? String,
              let id = dictionary[Keys.id.rawValue] as? Int,
              let spriteDict = dictionary[Keys.spritePath.rawValue] as? [String : Any],
              let spritePath = spriteDict[Keys.frontShiny.rawValue] as? String,
              let moves = dictionary[Keys.moves.rawValue] as? [[String : Any]] else {
                  print("You're A Failure At Exactly: \(#file)\(#line)")
                  return nil
              }
        
        var movesArray: [String] = []
        for dictionary in moves {
            
            guard let moveDict = dictionary[Keys.move.rawValue] as? [String : Any],
                  let moveName = moveDict[Keys.name.rawValue] as? String else { return nil }
            movesArray.append(moveName)
        }
        
        self.name = name
        self.id = id
        self.moves = movesArray
        self.spritePath = spritePath
    }
}
