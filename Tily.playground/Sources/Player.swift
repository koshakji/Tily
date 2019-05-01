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
    associatedtype CollectionType: AdvancedCollection where CollectionType.Element == SlidingTileBoard

    var collection : CollectionType { get set }
    var visited : Set<SlidingTileBoard> { get set }
}

extension StateSpaceSearchPlayer {
    mutating func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {
        
        collection.push(tileBoard)
        var countIn = 0, countOut = 0;
        
        while  !collection.isEmpty {
            let boardOptional = collection.pop()
            guard let board = boardOptional else { break }
            countOut += 1
            if visited.contains(board) {
                continue
            } else {
                visited.insert(board)
            }
            
            if board.isFinalState {
                visited.removeAll()
                print(countIn)
                print(countOut)
                return board
            } else {
                for nextNode in board.allPossibleNextStates() {
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
