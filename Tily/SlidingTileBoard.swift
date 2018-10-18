//
//  SlidingTileBoard.swift
//  Tily
//
//  Created by Majd Koshakji on 10/16/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

enum Direction {
    case up, down, left, right
}

class SlidingTileBoard {
    let width : Int
    let height : Int
    var array = [[Square]]()
    var shapes : [Int: [Square]]
    
    var gameOver : Bool { get {
        if let squares = shapes[0] {
            return squares.filter {
                $0.row == height - 1 && $0.column == width - 1
            }.count > 0
        }
        return false
        }
    }
    
    init(width: Int = 4, height: Int = 4) {
        self.width = width
        self.height = height
        
        for i in 0 ..< height {
            array.append([])
            for j in 0 ..< width {
                array[i].append(Square(row: i, column: j))
            }
        }
        
        shapes = [ 0 : [ Square(row: 0, column: 0, shape: 0) ] ]
        initializeSquareShapes()
        
    }
    
    func initializeSquareShapes() {
        for (shape, squares) in shapes {
            for square in squares {
                array[square.row][square.column].shape = shape
            }
        }
    }
    
    func canMove(shape: Int, _ direction: Direction) -> Bool {
        guard let squares = shapes[shape] else { return false }
        for square in squares {
            let location = nextSquareLocation(from: square, direction)
            
            
            guard location.i < height && location.i >= 0 else { return false }
            guard location.j < width && location.j >= 0 else { return false }
            
            let nextSquare = array[location.i][location.j]
            
            guard nextSquare.isEmpty || nextSquare.shape == shape else { return false }
        }
        return true
    }
    
    func move(shape: Int, _ direction: Direction) {
        guard canMove(shape: shape, direction) else { return }
        let squares = shapes[shape]!
        var movedShapeSquares = [Square]()
        
        for square in squares {
            
            let oldLocation = array[square.row][square.column]
            square.shape = nil
            oldLocation.shape = nil
            
            let nextLocation = nextSquareLocation(from: square, direction)
            let nextSquare = array[nextLocation.i][nextLocation.j]
            nextSquare.shape = shape
            movedShapeSquares.append(nextSquare)
        }
        
        shapes[shape] = movedShapeSquares
    }
    
    
    func nextSquareLocation(from square: Square, _ direction: Direction) -> (i: Int, j: Int) {
        switch direction {
        case .up:
            return (i: square.row - 1, j: square.column)
        case .down:
            return (i: square.row + 1, j: square.column)
        case .left:
            return (i: square.row, j: square.column - 1)
        case .right:
            return (i: square.row, j: square.column + 1)
            
        }
    }
}
