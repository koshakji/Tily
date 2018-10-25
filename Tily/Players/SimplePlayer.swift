//
//  Player.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

protocol SimplePlayerDelegate {
    func switchedCurrentBoard(current: SlidingTileBoard)
}

class SimplePlayer<TypeOfCollection>: Player where TypeOfCollection: Collection<SlidingTileBoard> {
    let tileBoard : SlidingTileBoard
    var visited = Set<SlidingTileBoard>()
    let delegate : SimplePlayerDelegate?
    
    init(tileBoard: SlidingTileBoard, delegate : SimplePlayerDelegate? = nil) {
        self.tileBoard = tileBoard
        self.delegate = delegate
    }
    
    func play() -> SlidingTileBoard? {
        let collection = TypeOfCollection(array: [tileBoard])
        visited.insert(tileBoard)
        
        while  !collection.isEmpty() {
            let boardOptional = collection.pop()
            guard let board = boardOptional else { break }
            
            delegate?.switchedCurrentBoard(current: board)
            
            
            if board.gameOver {
                return board
            } else {
                for nextNode in board.allPossibleMoves() {
                    if !visited.contains(nextNode) {
                        collection.push(item: nextNode)
                        visited.insert(nextNode)
                    }
                }
            }
        }
        return nil
    }
    
    
}
