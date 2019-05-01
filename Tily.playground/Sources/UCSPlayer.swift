//
//  UCSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/25/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class UCSPlayer: StateSpaceSearchPlayer {
    typealias CollectionType = PriorityQueue<SlidingTileBoard>
    var visited = Set<SlidingTileBoard>()
    var collection = PriorityQueue<SlidingTileBoard>(sort: { $0.moves < $1.moves })
    var description: String { get { return "UCS" }}
}
