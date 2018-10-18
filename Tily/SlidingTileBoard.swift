//
//  SlidingTileBoard.swift
//  Tily
//
//  Created by Majd Koshakji on 10/16/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

enum Direction: CaseIterable {
    case up, down, left, right
}

class SlidingTileBoard {
    let width : Int
    let height : Int
    var array = [[Square]]()
    var shapes = [Int: [Square]]()
    
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
        
        shapes[0] = [ array[1][1], array[2][1], array[2][2] ]
        shapes[1] = [ array[1][2] ]
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
        guard canMove(shape: shape, direction) else {
            print("cant")
            return
        }
        var squares = shapes[shape]!
        var movedShapeSquares = [Square]()
        
        squares.sort(by: sortClosure(for: direction))
        
        for square in squares {
            array[square.row][square.column].shape = nil
            
            let nextLocation = nextSquareLocation(from: square, direction)
            array[nextLocation.i][nextLocation.j].shape = shape
            let nextSquare = array[nextLocation.i][nextLocation.j]
            movedShapeSquares.append(nextSquare)
        }
        
        
        
        shapes[shape] = movedShapeSquares
    }
    
    
    func printArray() {
        
        var string = ""
        for i in 0 ..< height {
            for j in 0 ..< width {
                if let shape = array[i][j].shape {
                    string += "i:\(i)j:\(j) = \(shape)/  "
                } else {
                    string += "i:\(i)j:\(j) = nil/  "
                }
            }
            string += "\n"
        }
        print(string)
    }
    
    func sortClosure(for direction: Direction) -> ((Square,Square) -> Bool) {
        switch direction {
        case .up:
            return { $0.row < $1.row }
        case .down:
            return { $0.row > $1.row }
        case .left:
            return { $0.column < $1.column }
        case .right:
            return { $0.column > $1.column }
            
        }
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
    
    func sameShapeNeighborFor(row: Int, column: Int, at direction: Direction) -> Bool {
        let location = nextSquareLocation(from: Square(row: row, column: column), direction)
        guard location.i < height && location.i >= 0 else { return false }
        guard location.j < width && location.j >= 0 else { return false }
        return array[location.i][location.j].shape == array[row][column].shape
    }
}
