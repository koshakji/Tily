//
//  HillClimbingPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/31/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

struct HillClimbingPlayer: StateSpaceSearchPlayer {
    var visited = Set<SlidingTileBoard>()
    var collection = PriorityQueue<SlidingTileBoard>(sort: { ($0.calculateMainManhattenDistance()) < ($1.calculateMainManhattenDistance()) })
    var description: String { get { return "Hilly" }}
}
