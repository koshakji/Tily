//
//  UCSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/25/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class UCSPlayer : Player {
    var visited = Set<SlidingTileBoard>()
    
    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {
        var priorityQ = PriorityQueue<SlidingTileBoard> {
            $0.moves < $1.moves
        }
        
        priorityQ.enqueue(tileBoard)
        
        visited.insert(tileBoard)
        while  !priorityQ.isEmpty {
            let boardOptional = priorityQ.dequeue()
            guard let board = boardOptional else { break }

            if board.gameOver {
                return board
            } else {
                for nextNode in board.allPossibleMoves() {
                    if !visited.contains(nextNode) {
                        priorityQ.enqueue(nextNode)
                        visited.insert(nextNode)
                    }
                }
            }
        }
        return nil
    }
    
    
}
