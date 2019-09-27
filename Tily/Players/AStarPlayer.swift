//
//  AStarPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/30/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

struct AStarPlayer: StateSpaceSearchPlayer {
    var visited = Set<SlidingTileBoard>()
    var collection = PriorityQueue<SlidingTileBoard>(sort: { ($0.moves + $0.calculateMainManhattenDistance()) < ($1.moves + $1.calculateMainManhattenDistance()) })
    var description: String { get { return "AStar" }}
}
