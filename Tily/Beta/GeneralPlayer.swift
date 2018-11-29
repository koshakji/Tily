//
//  GeneralPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 11/5/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class GeneralPlayer<T: SlidingTileCollection>: Player {

    var visited = Set<SlidingTileBoard>()
    var stringValue : String { get { return "" } }
    var collection : T
    
    init(collection: T) {
        self.collection = collection
    }

    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard? {

        collection.push(tileBoard)

        while  !collection.isEmpty {
            let boardOptional = collection.pop()
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

class otherDFSPlayer: GeneralPlayer<SlidingBoardStack> {
    
    override var stringValue : String { get { return "Other DFS" } }

    init() {
        super.init(collection: SlidingBoardStack())
    }
}

class otherBFSPlayer: GeneralPlayer<SlidingBoardQueue> {
    
    override var stringValue : String { get { return "Other BFS" } }

    init() {
        super.init(collection: SlidingBoardQueue())
    }
}

class otherUCSPlayer: GeneralPlayer<SlidingBoardPriorityQueue> {
    
    override var stringValue : String { get { return "Other UCS" } }
    
    init() {
        super.init(collection: SlidingBoardPriorityQueue(sort: { $0.moves < $1.moves }))
    }
}

class otherAStarPlayer: GeneralPlayer<SlidingBoardPriorityQueue> {
    
    override var stringValue : String { get { return "Other A-Star" } }
    
    init() {
        super.init(collection: SlidingBoardPriorityQueue(sort: { ($0.moves + $0.mainManhattanDistance) < ($1.moves + $1.mainManhattanDistance) }))
    }
}

class otherHillClimbingPlayer: GeneralPlayer<SlidingBoardPriorityQueue> {
    
    override var stringValue : String { get { return "Other Hill Climbing" } }
    
    init() {
        super.init(collection: SlidingBoardPriorityQueue(sort: { ($0.mainManhattanDistance) < ($1.mainManhattanDistance) }))
    }
}
