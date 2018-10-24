//
//  Player.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class Player {
    let tileBoard : SlidingTileBoard
    let visited = Set<SlidingTileBoard>()
    
    init(tileBoard: SlidingTileBoard) {
        self.tileBoard = tileBoard
    }
}
