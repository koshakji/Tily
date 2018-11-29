//
//  HillClimbingPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/31/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class HillClimbingPlayer: Player {
    var visited = Set<SlidingTileBoard>()
    var stringValue : String { get { return "Hill Climbing" } }
    
    
    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {
        var priorityQ = PriorityQueue<SlidingTileBoard> {
            ($0.mainManhattanDistance) < ($1.mainManhattanDistance)
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
            
            
            if board.isFinalState {
                visited.removeAll()
                return board
            } else {
                for nextNode in board.allPossibleNextStates() {
                    if !visited.contains(nextNode) {
                        priorityQ.push(nextNode)
                        nextNode.parent = board
                    }
                }
            }
        }
        visited.removeAll()
        return nil
    }
    
    
}
