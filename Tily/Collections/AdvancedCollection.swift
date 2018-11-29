//
//  AdvancedCollection.swift
//  Tily
//
//  Created by Majd Koshakji on 11/29/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

protocol AdvancedCollection {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var count: Int { get }
    func peek() -> Element?
    mutating func pop() -> Element?
    mutating func push(_ element: Element)
}
