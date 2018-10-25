//
//  PriorityQueue.swift
//  Tily
//
//  Created by Majd Koshakji on 10/25/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class PriorityQueue<T>: Queue<T> where T:Comparable {
    let sortClosure: (T, T) -> Bool = { $0 < $1 }
    
    override func push(item: T) {
        super.push(item: item)
        array.sort(by: sortClosure)
    }
}
