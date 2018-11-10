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
    var stringValue : String { get { return "BFS" } }

    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {
        var queue = Queue<SlidingTileBoard>()
        
        queue.push(tileBoard)
        
        while  !queue.isEmpty {
            let boardOptional = queue.pop()
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
                    queue.push(nextNode)
                    nextNode.parent = board
                }
            }
        }
        visited.removeAll()
        return nil
    }
    
}
