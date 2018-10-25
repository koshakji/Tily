//
//  Collection.swift
//  Tily
//
//  Created by Majd Koshakji on 10/25/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class Collection<T> {
    var array : [T]
    
    required init( array : [T] = [] ) {
        self.array = array
    }
    
    func push(item: T) {
        array.append(item)
    }
    
    func pop() -> T? {
        return nil
    }
    
    func peek() -> T? {
        return nil
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
}
