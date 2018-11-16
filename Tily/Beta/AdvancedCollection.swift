//
//  AdvancedCollection.swift
//  Tily
//
//  Created by Majd Koshakji on 11/5/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

protocol SlidingTileCollection {
    var isEmpty: Bool { get }
    var count: Int { get }
    func peek() -> SlidingTileBoard?
    mutating func pop() -> SlidingTileBoard?
    mutating func push(_ element: SlidingTileBoard)
}

class SlidingBoardStack: Stack<SlidingTileBoard>, SlidingTileCollection {}

class SlidingBoardQueue: Queue<SlidingTileBoard>, SlidingTileCollection {}

class SlidingBoardPriorityQueue: PriorityQueue<SlidingTileBoard>, SlidingTileCollection {}
