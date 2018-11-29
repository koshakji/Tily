//
//  StateSpace.swift
//  Tily
//
//  Created by Majd Koshakji on 11/29/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

protocol StateSpace {
    var isFinalState : Bool { get }
    func allPossibleNextStates() -> [Self]
}
