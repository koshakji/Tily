//
//  AStarPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/30/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class AStarPlayer: StateSpaceSearchPlayer {
    typealias CollectionType = PriorityQueue<SlidingTileBoard>
    var visited = Set<SlidingTileBoard>()
    var collection = PriorityQueue<SlidingTileBoard>(sort: { ($0.moves + $0.mainManhattanDistance) < ($1.moves + $1.mainManhattanDistance) })
    var description: String { get { return "AStar" }}
}