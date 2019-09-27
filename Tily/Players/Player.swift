//
//  Player.swift
//  Tily
//
//  Created by Majd Koshakji on 10/25/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

protocol Player: CustomStringConvertible {
    mutating func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard?
}

protocol StateSpaceSearchPlayer: Player {
    associatedtype gameType: StateSpaceSearchable, Hashable
    associatedtype CollectionType: AdvancedCollection where CollectionType.Element == gameType
    

    var collection : CollectionType { get set }
    var visited : Set<gameType> { get set }
}

extension StateSpaceSearchPlayer {
    mutating func play(startingWith game: gameType) -> gameType? {
        
        collection.push(game)
        var countIn = 0, countOut = 0;
        
        while  !collection.isEmpty {
            guard let board = collection.pop() else { break }
            countOut += 1
            if visited.contains(board) {
                continue
            } else {
                visited.insert(board)
            }
            
            if board.isFinalState {
                visited.removeAll()
                return board
            } else {
                for var nextNode in board.allPossibleNextStates() {
                    if !visited.contains(nextNode) {
                        countIn += 1
                        collection.push(nextNode)
                        nextNode.parent = board
                    }
                }
            }
        }
        visited.removeAll()
        return nil
    }
}
