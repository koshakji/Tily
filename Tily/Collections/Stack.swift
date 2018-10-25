//
//  Stack.swift
//  Tily
//
//  Created by Majd Koshakji on 10/25/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class Stack <T> : Collection<T> {
    override func pop() -> T? {
        return array.removeLast()
    }
    
    override func peek() -> T? {
        return array.last
    }
}
