//
//  Square.swift
//  Tily
//
//  Created by Majd Koshakji on 10/16/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class Square {
    let row : Int
    let column : Int
    var shape : Int?
    
    var isEmpty : Bool { get { return shape == nil } }
    
    init(row: Int, column: Int, shape: Int? = nil) {
        self.row = row
        self.column  = column
        self.shape = shape
    }
    
    init() {
        self.row = 0
        self.column = 0
        self.shape = nil
    }
}
