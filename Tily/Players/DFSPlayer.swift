//
//  DFSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class DFSPlayer: Player {
    var visited = Set<SlidingTileBoard>()
    var stringValue : String { get { return "DFS" } }

    
    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {
        var stack = Stack<SlidingTileBoard>()
        
        stack.push(tileBoard)
        visited.insert(tileBoard)
        while  !stack.isEmpty {
            let boardOptional = stack.pop()
            guard let board = boardOptional else { break }
            
            if board.gameOver {
                visited.removeAll()
                return board
            } else {
                for nextNode in board.allPossibleMoves() {
                    if !visited.contains(nextNode) {
                        stack.push(nextNode)
                        visited.insert(nextNode)
                        nextNode.parent = board
                    }
                }
            }
        }
        visited.removeAll()
        return nil
    }
}
