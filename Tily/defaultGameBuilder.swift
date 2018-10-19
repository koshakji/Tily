//
//  defaultGameBuilder.swift
//  Tily
//
//  Created by Majd Koshakji on 10/18/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation

class DefaultGameBuilder {
    let games: [SlidingTileBoard]
    
    init() {
        
        let one = SlidingTileBoard(name: "2 Pieces")
        one.shapes[0] = [one.array[1][0], one.array[0][0], one.array[0][1], one.array[0][2], one.array[1][2], one.array[2][2] ]
        one.shapes[1] = [one.array[1][1], one.array[2][1], one.array[2][0]]
        one.initializeSquareShapes()
        
        
        let two = SlidingTileBoard(name: "3 Pieces")
        two.shapes[0] = [ two.array[1][0], two.array[2][0], two.array[2][1] ]
        two.shapes[1] = [ two.array[1][2], two.array[2][2], two.array[2][3], two.array[3][3] ]
        two.shapes[2] = [ two.array[3][1], two.array[3][2] ]
        two.initializeSquareShapes()
        
        
        let three = SlidingTileBoard(name: "4 Pieces")
        three.shapes[0] = [ three.array[0][3], three.array[0][2], three.array[1][2] ]
        three.shapes[1] = [ three.array[1][0], three.array[1][1] ]
        three.shapes[2] = [ three.array[2][1], three.array[3][1], three.array[3][0] ]
        three.shapes[3] = [ three.array[2][2], three.array[3][2] ]
        three.initializeSquareShapes()
        
        
        let four = SlidingTileBoard(name: "5 Pieces")
        four.shapes[0] = [ four.array[0][0], four.array[1][0] ]
        four.shapes[1] = [ four.array[2][0] ]
        four.shapes[2] = [ four.array[0][2], four.array[0][3] ]
        four.shapes[3] = [ four.array[1][2], four.array[2][2], four.array[2][3] ]
        four.shapes[4] = [ four.array[2][1], four.array[3][1], four.array[3][2] ]
        four.initializeSquareShapes()
        
        let five = SlidingTileBoard(name: "6 Pieces")
        five.shapes[0] = [ five.array[0][1] ]
        five.shapes[1] = [ five.array[1][0] ]
        five.shapes[2] = [ five.array[1][3] ]
        five.shapes[3] = [ five.array[2][0], five.array[2][1] ]
        five.shapes[4] = [ five.array[0][2], five.array[1][2], five.array[1][1], five.array[2][2] ]
        five.shapes[5] = [ five.array[2][3], five.array[3][3], five.array[3][2] ]
        five.initializeSquareShapes()
        
        let six = SlidingTileBoard(name: "7 Pieces")
        six.shapes[0] = [ six.array[0][1], six.array[0][2], six.array[1][1] ]
        six.shapes[1] = [ six.array[1][0] ]
        six.shapes[2] = [ six.array[2][0] ]
        six.shapes[3] = [ six.array[3][3] ]
        six.shapes[4] = [ six.array[1][2], six.array[1][3] ]
        six.shapes[5] = [ six.array[2][2], six.array[2][3] ]
        six.shapes[6] = [ six.array[2][1], six.array[3][1], six.array[3][2] ]
        six.initializeSquareShapes()
        
        let seven = SlidingTileBoard(name: "8 Pieces")
        seven.shapes[0] = [ seven.array[0][1], seven.array[0][2] ]
        seven.shapes[1] = [ seven.array[0][3], seven.array[1][3] ]
        seven.shapes[2] = [ seven.array[1][0], seven.array[1][1] ]
        seven.shapes[3] = [ seven.array[2][0], seven.array[3][0] ]
        seven.shapes[4] = [ seven.array[2][3], seven.array[3][3] ]
        seven.shapes[5] = [ seven.array[2][1], seven.array[2][2] ]
        seven.shapes[6] = [ seven.array[1][2] ]
        seven.shapes[7] = [ seven.array[3][2] ]
        seven.initializeSquareShapes()
        
        let eight = SlidingTileBoard(name: "9 Pieces")
        eight.shapes[0] = [ eight.array[0][0], eight.array[0][1] ]
        eight.shapes[1] = [ eight.array[1][0], eight.array[2][0] ]
        eight.shapes[2] = [ eight.array[2][1], eight.array[3][1] ]
        eight.shapes[3] = [ eight.array[1][1] ]
        eight.shapes[4] = [ eight.array[0][3] ]
        eight.shapes[5] = [ eight.array[2][2] ]
        eight.shapes[6] = [ eight.array[2][3] ]
        eight.shapes[7] = [ eight.array[3][2] ]
        eight.shapes[8] = [ eight.array[0][2], eight.array[1][2], eight.array[1][3] ]
        eight.initializeSquareShapes()
        
        let nine = SlidingTileBoard(name: "10 Pieces")
        nine.shapes[0] = [ nine.array[0][0] ]
        nine.shapes[1] = [ nine.array[1][0] ]
        nine.shapes[2] = [ nine.array[1][1] ]
        nine.shapes[3] = [ nine.array[1][2] ]
        nine.shapes[4] = [ nine.array[2][1] ]
        nine.shapes[5] = [ nine.array[3][3] ]
        nine.shapes[6] = [ nine.array[2][0], nine.array[3][0] ]
        nine.shapes[7] = [ nine.array[2][2], nine.array[2][3] ]
        nine.shapes[8] = [ nine.array[3][1], nine.array[3][2] ]
        nine.shapes[9] = [ nine.array[0][1], nine.array[0][2], nine.array[0][3] ]
        nine.initializeSquareShapes()
        
        let ten = SlidingTileBoard(name: "11 Pieces")
        ten.shapes[0] = [ ten.array[0][0] ]
        ten.shapes[1] = [ ten.array[0][1] ]
        ten.shapes[2] = [ ten.array[0][2] ]
        ten.shapes[3] = [ ten.array[0][3] ]
        ten.shapes[4] = [ ten.array[1][0] ]
        ten.shapes[5] = [ ten.array[1][2] ]
        ten.shapes[6] = [ ten.array[1][3] ]
        ten.shapes[7] = [ ten.array[3][1] ]
        ten.shapes[8] = [ ten.array[2][0], ten.array[3][0] ]
        ten.shapes[9] = [ ten.array[3][2], ten.array[3][3] ]
        ten.shapes[10] = [ ten.array[1][1], ten.array[2][1], ten.array[2][2] ]
        ten.initializeSquareShapes()
        
        let eleven = SlidingTileBoard(name: "12 Pieces")
        eleven.shapes[0] = [ eleven.array[0][0] ]
        eleven.shapes[1] = [ eleven.array[0][1] ]
        eleven.shapes[2] = [ eleven.array[0][2] ]
        eleven.shapes[3] = [ eleven.array[0][3] ]
        eleven.shapes[4] = [ eleven.array[1][0] ]
        eleven.shapes[5] = [ eleven.array[1][2] ]
        eleven.shapes[6] = [ eleven.array[1][3] ]
        eleven.shapes[7] = [ eleven.array[2][3] ]
        eleven.shapes[8] = [ eleven.array[3][3] ]
        eleven.shapes[9] = [ eleven.array[3][2] ]
        eleven.shapes[10] = [ eleven.array[2][0], eleven.array[3][0] ]
        eleven.shapes[11] = [ eleven.array[1][1], eleven.array[2][1], eleven.array[2][2] ]
        eleven.initializeSquareShapes()

        let twelve = SlidingTileBoard(name: "13 Pieces")
        twelve.shapes[0] = [ twelve.array[0][0] ]
        twelve.shapes[1] = [ twelve.array[0][1] ]
        twelve.shapes[2] = [ twelve.array[0][2] ]
        twelve.shapes[3] = [ twelve.array[0][3] ]
        twelve.shapes[4] = [ twelve.array[1][0] ]
        twelve.shapes[5] = [ twelve.array[1][1] ]
        twelve.shapes[6] = [ twelve.array[1][3] ]
        twelve.shapes[7] = [ twelve.array[2][0] ]
        twelve.shapes[8] = [ twelve.array[2][3] ]
        twelve.shapes[9] = [ twelve.array[3][0] ]
        twelve.shapes[10] = [ twelve.array[3][1] ]
        twelve.shapes[11] = [ twelve.array[3][2] ]
        twelve.shapes[12] = [ twelve.array[1][2], twelve.array[2][1], twelve.array[2][2] ]
        twelve.initializeSquareShapes()
        
        let thirteen = SlidingTileBoard(name: "14 Pieces")
        thirteen.shapes[0] = [ thirteen.array[0][0] ]
        thirteen.shapes[1] = [ thirteen.array[0][1] ]
        thirteen.shapes[2] = [ thirteen.array[0][2] ]
        thirteen.shapes[3] = [ thirteen.array[0][3] ]
        thirteen.shapes[4] = [ thirteen.array[1][0] ]
        thirteen.shapes[5] = [ thirteen.array[1][1] ]
        thirteen.shapes[6] = [ thirteen.array[1][2] ]
        thirteen.shapes[7] = [ thirteen.array[1][3] ]
        thirteen.shapes[8] = [ thirteen.array[2][0] ]
        thirteen.shapes[9] = [ thirteen.array[2][1] ]
        thirteen.shapes[10] = [ thirteen.array[2][3] ]
        thirteen.shapes[11] = [ thirteen.array[3][0] ]
        thirteen.shapes[12] = [ thirteen.array[3][1] ]
        thirteen.shapes[13] = [ thirteen.array[2][2], thirteen.array[3][2] ]
        thirteen.initializeSquareShapes()
        
        let forteen = SlidingTileBoard(name: "15 Pieces")
        forteen.shapes[0] = [ forteen.array[0][0] ]
        forteen.shapes[1] = [ forteen.array[0][1] ]
        forteen.shapes[2] = [ forteen.array[0][2] ]
        forteen.shapes[3] = [ forteen.array[0][3] ]
        forteen.shapes[4] = [ forteen.array[1][0] ]
        forteen.shapes[5] = [ forteen.array[1][1] ]
        forteen.shapes[6] = [ forteen.array[1][2] ]
        forteen.shapes[7] = [ forteen.array[1][3] ]
        forteen.shapes[8] = [ forteen.array[2][0] ]
        forteen.shapes[9] = [ forteen.array[2][1] ]
        forteen.shapes[10] = [ forteen.array[2][2] ]
        forteen.shapes[11] = [ forteen.array[2][3] ]
        forteen.shapes[12] = [ forteen.array[3][0] ]
        forteen.shapes[13] = [ forteen.array[3][1] ]
        forteen.shapes[14] = [ forteen.array[3][2] ]
        forteen.initializeSquareShapes()
        
        
        let fifteen = SlidingTileBoard(name: "5 Pieces 2.0")
        fifteen.shapes[0] = [ fifteen.array[0][3] ]
        fifteen.shapes[1] = [ fifteen.array[3][3] ]
        fifteen.shapes[2] = [ fifteen.array[2][0], fifteen.array[2][1] ]
        fifteen.shapes[3] = [ fifteen.array[3][0], fifteen.array[3][1] ]
        fifteen.shapes[4] = [ fifteen.array[1][1], fifteen.array[1][2], fifteen.array[2][2], fifteen.array[2][3], fifteen.array[3][2] ]
        fifteen.initializeSquareShapes()
        
        games = [one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, forteen, fifteen]
    }
    
    
}
