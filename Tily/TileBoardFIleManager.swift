//
//  TileBoardFIleManager.swift
//  Tily
//
//  Created by Majd Koshakji on 10/18/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

struct TileBoardFileManager {
    var documentDirectory: URL { get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    var archiveURL: URL { get {
            return self.documentDirectory.appendingPathComponent("TileBoardGames").appendingPathExtension("plist")
        }
    }
    let propertyListEncoder = PropertyListEncoder()
    let propertyListDecoder = PropertyListDecoder()
    
    func save(games: [SlidingTileBoard]) -> Bool {
        let encodedGamesOptional = try? self.propertyListEncoder.encode(games)
        guard let encodedGames = encodedGamesOptional else { return false }
        if let _ = try? encodedGames.write(to: archiveURL, options: .noFileProtection) {
            return true
        } else {
            return false
        }
    }
    
    func read() -> [SlidingTileBoard]? {
        if let retrievedGamesData = try? Data(contentsOf: archiveURL) {
            let decodedGames = try? self.propertyListDecoder.decode(Array<SlidingTileBoard>.self, from: retrievedGamesData)
            return decodedGames
        }
        return nil
    }
}
