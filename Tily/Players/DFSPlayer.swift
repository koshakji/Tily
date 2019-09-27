//
//  DFSPlayer.swift
//  Tily
//
//  Created by Majd Koshakji on 10/23/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

struct DFSPlayer: StateSpaceSearchPlayer {
    var visited = Set<SlidingTileBoard>()
    var collection = Stack<SlidingTileBoard>()
    
    var description: String { get { return "DFS" }}
}
