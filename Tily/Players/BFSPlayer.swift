//
//  BFSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class BFSPlayer: Player {
    func play() -> SlidingTileBoard? {
        var queue = [tileBoard]
        
        while queue.count != 0 {
            let board = queue.removeFirst()

            
            if board.gameOver {
                return board
            } else {
                for nextNode in board.allPossibleMoves() {
                    if !visited.contains(nextNode) {
                        queue.append(nextNode)
                    }
                }
            }
        }
        return nil
    }
}
