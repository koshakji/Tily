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
    func squaresMoved(old: [Square], new: [Square])
}

final class SlidingTileBoard: Codable, StateSpaceSearchable {
    let name: String
    let width : Int
    let height : Int
    var array = [[Square]]()
    var shapes = [Int: [Square]]()
    var moves : Int
    
    //for saving path
    var parent : SlidingTileBoard? = nil
    
    var delegate : SlidingTileBoardDelegate?
    
    var isFinalState : Bool { get {
        guard let squares = shapes[0] else { return false }
        let columns = squares.map { $0.column }.sorted()
        let rows = squares.map { $0.row }.sorted()
        return rows.last! == height - 1 && columns.last! == width - 1
        }
    }
    
    var lastSquare : Square { get { return array[height - 1][width - 1] }}
    
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
        self.moves = game.moves
        //self.delegate = game.delegate
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
    
    func checkGameOver() {
        if isFinalState {
            delegate?.slidingTileGameOver()
        }
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
        delegate?.squaresMoved(old: squares, new: movedShapeSquares)
        checkGameOver()
    }
    
    func moveState(shape: Int, _ direction: Direction) -> SlidingTileBoard? {
        if canMove(shape: shape, direction) {
            let newGame = SlidingTileBoard(copyFrom: self)
            newGame.move(shape: shape, direction)
            return newGame
        } else {
            return nil
        }
        
    }
    
    func allPossibleNextStates() -> Array<SlidingTileBoard> {
        let allDirections = Direction.allCases
        var result = Array<SlidingTileBoard>()
        for (shape, _) in shapes {
            for direction in allDirections {
                if let state = moveState(shape: shape, direction) {
                 result.append(state)
                }
            }
        }
        return result
    }
    
    func shapeManhattanDistance(shape shapeNumber: Int = 0, to square: Square) -> Int? {
        guard let shape = shapes[shapeNumber] else { return nil }
        let distances = shape.map { $0 - square }
        return distances.min()
    }
    
    func calculateMainManhattenDistance() -> Int {
        shapeManhattanDistance(to: lastSquare) ?? Int.max
    }

    func printArray() {
        var string = ""
        for i in 0 ..< height {
            for j in 0 ..< width {
                if let shape = array[i][j].shape {
                    string += "i:\(i)j:\(j) = \(shape) |  "
                } else {
                    string += "i:\(i)j:\(j) = n |  "
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
    
    enum CodingKeys: String, CodingKey {
        case name
        case width
        case height
        case array
        case shapes
        case moves
    }
}

extension SlidingTileBoardDelegate {
    func squaresMoved(old: [Square], new: [Square]) {}
}


extension SlidingTileBoard : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(array)
    }
    
    static func == (lhs: SlidingTileBoard, rhs: SlidingTileBoard) -> Bool {
        return lhs.array == rhs.array
    }
}

extension SlidingTileBoard: Comparable {
    static func < (lhs: SlidingTileBoard, rhs: SlidingTileBoard) -> Bool {
        return lhs.moves < rhs.moves
    }
}
