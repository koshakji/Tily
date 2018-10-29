//
//  BFSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class BFSPlayer: Player {
    var visited = Set<SlidingTileBoard>()

    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {
        var queue = Queue<SlidingTileBoard>()
        
        queue.enqueue(tileBoard)
        visited.insert(tileBoard)
        
        while  !queue.isEmpty {
            let boardOptional = queue.dequeue()
            guard let board = boardOptional else { break }
            
            
            if board.gameOver {
                return board
            } else {
                for nextNode in board.allPossibleMoves() {
                    if !visited.contains(nextNode) {
                        queue.enqueue(nextNode)
                        visited.insert(nextNode)
                    }
                }
            }
        }
        return nil
    }
}
