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
    var stringValue : String { get { return "UCS" } }

    
    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {
        var priorityQ = PriorityQueue<SlidingTileBoard> {
            $0.moves < $1.moves
        }
        
        priorityQ.push(tileBoard)
        
        while  !priorityQ.isEmpty {
            let boardOptional = priorityQ.pop()
            guard let board = boardOptional else { break }
            
            if visited.contains(board) {
                continue
            } else {
                visited.insert(board)
            }
            
            
            if board.gameOver {
                visited.removeAll()
                return board
            }
            for nextNode in board.allPossibleMoves() {
                if !visited.contains(nextNode) {
                    priorityQ.push(nextNode)
                    nextNode.parent = board
                }
            }
        }
        visited.removeAll()
        return nil
    }
    
}
