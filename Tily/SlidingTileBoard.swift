//
//  SlidingTileBoard.swift
//  Tily
//
//  Created by Majd Koshakji on 10/16/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

enum Direction: CaseIterable {
    case Up, Down, Left, Right
}

protocol SlidingTileBoardDelegate {
    func slidingTileGameOver()
}

class SlidingTileBoard: Codable, Equatable {
    let name: String
    let width : Int
    let height : Int
    var array = [[Square]]()
    var shapes = [Int: [Square]]()
    var moves : Int
    
    var delegate : SlidingTileBoardDelegate?
    
    var gameOver : Bool { get {
        if let squares = shapes[0] {
            let endSquares = squares.filter {
                $0.row == height - 1 && $0.column == width - 1
            }
            return endSquares.count > 0
        }
        return false
        }
    }
    
    init(name: String = "game", width: Int = 4, height: Int = 4, delegate: SlidingTileBoardDelegate? = nil) {
        self.name = name
        self.width = width
        self.height = height
        self.delegate = delegate
        self.moves = 0
        
        for i in 0 ..< height {
            array.append([])
            for j in 0 ..< width {
                array[i].append(Square(row: i, column: j))
            }
        }
    }
    
    init(copyFrom game: SlidingTileBoard) {
        self.name = game.name
        self.width = game.width
        self.height = game.height
        self.array = game.array
        self.shapes = game.shapes
        self.moves = 0
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
        moves += 1
        if gameOver {
           delegate?.slidingTileGameOver()
        }
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
        case .Up:
            return { $0.row < $1.row }
        case .Down:
            return { $0.row > $1.row }
        case .Left:
            return { $0.column < $1.column }
        case .Right:
            return { $0.column > $1.column }
            
        }
    }
    
    func nextSquareLocation(from square: Square, _ direction: Direction) -> (i: Int, j: Int) {
        switch direction {
        case .Up:
            return (i: square.row - 1, j: square.column)
        case .Down:
            return (i: square.row + 1, j: square.column)
        case .Left:
            return (i: square.row, j: square.column - 1)
        case .Right:
            return (i: square.row, j: square.column + 1)
            
        }
    }
    
    func sameShapeNeighborFor(row: Int, column: Int, at direction: Direction) -> Bool {
        let location = nextSquareLocation(from: Square(row: row, column: column), direction)
        guard location.i < height && location.i >= 0 else { return false }
        guard location.j < width && location.j >= 0 else { return false }
        guard let shape = array[location.i][location.j].shape else { return false }
        return shape == array[row][column].shape
    }
    
    static func == (lhs: SlidingTileBoard, rhs: SlidingTileBoard) -> Bool {
        return lhs.array == rhs.array
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case width
        case height
        case array
        case shapes
        case moves
    }
}
