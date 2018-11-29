//
//  BFSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class BFSPlayer: StateSpaceSearchPlayer {
    typealias CollectionType = Queue<SlidingTileBoard>
    var visited = Set<SlidingTileBoard>()
    var collection = Queue<SlidingTileBoard>()
    
    var description: String { get { return "BFS" }}
}
