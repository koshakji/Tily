//
//  Player.swift
//  Tily
//
//  Created by Majd Koshakji on 10/25/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

protocol Player {
    //var path: [SlidingTileBoard] { get set }
    var visited : Set<SlidingTileBoard> { get set }
    func play(startingWith tileBoard: SlidingTileBoard) -> SlidingTileBoard?
}
