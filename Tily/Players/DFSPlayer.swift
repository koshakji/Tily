//
//  DFSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class DFSPlayer: Player {
    
    func play() -> SlidingTileBoard? {
        var stack = [tileBoard]
        while !stack.isEmpty {
            let board = stack.removeLast()
            board.printArray()
            
            if board.gameOver {
                return board
            } else {
                for nextNode in board.allPossibleMoves() {
                    if !visited.contains(nextNode) {
                        stack.append(nextNode)
                    }
                }
            }
        }
        return nil
    }
}
