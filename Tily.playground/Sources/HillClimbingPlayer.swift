//
//  HillClimbingPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/31/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class HillClimbingPlayer: StateSpaceSearchPlayer {
    typealias CollectionType = PriorityQueue<SlidingTileBoard>
    var visited = Set<SlidingTileBoard>()
    var collection = PriorityQueue<SlidingTileBoard>(sort: { ($0.mainManhattanDistance) < ($1.mainManhattanDistance) })
    var description: String { get { return "Hilly" }}
}
