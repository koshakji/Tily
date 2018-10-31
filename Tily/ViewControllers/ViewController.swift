//
//  ViewController.swift
//  Tily
//
//  Created by Majd Koshakji on 10/16/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    var tileBoard : SlidingTileBoard!
    var buttons = [[UIView]]()
    var player : Player?
    var path : Array<SlidingTileBoard>! = Array<SlidingTileBoard>()
    var step : Int = 0
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var nextMoveButton: UIBarButtonItem!
    @IBOutlet weak var previousMoveButton: UIBarButtonItem!
    @IBOutlet weak var playerSelectionButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tileBoard.delegate = self
        
        for i in 0 ..< tileBoard.height {
            buttons.append([])
            for j in 0 ..< tileBoard.width {
                let view = UIView()
                
                setColorFor(button: view, i: i, j: j)
                view.tag = i * tileBoard.width + j
                addGestureRecognizors(to: view)
                view.translatesAutoresizingMaskIntoConstraints = false
                buttons[i].append(view)
            }
            let lineStackView = UIStackView(arrangedSubviews: buttons[i])
            lineStackView.translatesAutoresizingMaskIntoConstraints = false
            lineStackView.alignment = .fill
            lineStackView.distribution = .fillEqually
            lineStackView.axis = .horizontal
            mainStackView.addArrangedSubview(lineStackView)
        }
        if player == nil {
            playButton.isEnabled = false
        }
        nextMoveButton.isEnabled = false
        previousMoveButton.isEnabled = false
    }

    // MARK: Setup Views
    func addGestureRecognizors(to button: UIView) {
        let rightGestureRecognizor = UISwipeGestureRecognizer(target: self, action: #selector(selectShapeAndSwipeRight(_:)))
        rightGestureRecognizor.direction = .right
        button.addGestureRecognizer(rightGestureRecognizor)
        
        let leftGestureRecognizor = UISwipeGestureRecognizer(target: self, action: #selector(selectShapeAndSwipeLeft(_:)))
        leftGestureRecognizor.direction = .left
        button.addGestureRecognizer(leftGestureRecognizor)
        
        let upGestureRecognizor = UISwipeGestureRecognizer(target: self, action: #selector(selectShapeAndSwipeUp(_:)))
        upGestureRecognizor.direction = .up
        button.addGestureRecognizer(upGestureRecognizor)
        
        let downGestureRecognizor = UISwipeGestureRecognizer(target: self, action: #selector(selectShapeAndSwipeDown(_:)))
        downGestureRecognizor.direction = .down
        button.addGestureRecognizer(downGestureRecognizor)
    }
    
    // MARK: UI Actions
    
    @objc func exitGame() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectShapeAndSwipeRight(_ sender: UISwipeGestureRecognizer) {
        selectAndMoveShape(at: sender.view!, to: .Right)
    }
    
    @objc func selectShapeAndSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        selectAndMoveShape(at: sender.view!, to: .Left)
    }
    
    @objc func selectShapeAndSwipeUp(_ sender: UISwipeGestureRecognizer) {
        selectAndMoveShape(at: sender.view!, to: .Up)
    }
    
    @objc func selectShapeAndSwipeDown(_ sender: UISwipeGestureRecognizer) {
        selectAndMoveShape(at: sender.view!, to: .Down)
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        guard let player = player else {
            playButton.isEnabled = false
            return
        }
        
        path.removeAll()
        step = 0
        
        let result = player.play(startingWith: tileBoard)
        if let result = result {
            tileBoard = result
            tileBoard.delegate = self
            tileBoard.checkGameOver()
            setButtonColors()
            buildParents(tileBoard)
        } else {
            let alertController = UIAlertController(title: "Computer couldn't win", message: "The chosen algorithm failed to solve the current puzzle 😔", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.player = nil
            playButton.isEnabled = false
            present(alertController, animated: true)
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        step -= 1
        if step < 0 {
            step = path.count - 1
        }
        getStepState()
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        step += 1
        if step >= path.count {
            step = 0
        }
        getStepState()
    }
    
    
    // MARK: ViewModel
    func selectAndMoveShape(at button: UIView, to direction: Direction) {
        let location = getIandJ(from: button.tag)
        let shapeNumber = tileBoard.array[location.i][location.j].shape
        guard let shape = shapeNumber else { return }
        tileBoard.move(shape: shape, direction)
    }
    
    func buildParents(_ starting: SlidingTileBoard) {
        path.append(starting)
        var boardOptional : SlidingTileBoard? = starting
        while boardOptional != nil {
            guard let board = boardOptional else { break }
            path.append(board)
            boardOptional = board.parent
        }
        path.reverse()
        
        if path.count > 0 {
            nextMoveButton.isEnabled = true
            previousMoveButton.isEnabled = true
            step = path.count - 1
        }
    }
    
    func getStepState() {
        guard step < path.count && step >= 0 else { return }
        tileBoard = path[step]
        tileBoard.delegate = self
        setButtonColors()
    }
    
    // MARK: Helper Functions
    func getIandJ(from value: Int) -> (i: Int, j: Int) {
        let row : Int = value / tileBoard.width
        let column: Int = value % tileBoard.width
        return (row,column)
    }
    
    // MARK: Coloring
    func setColorFor(button: UIView, i: Int, j: Int) {
        let number = tileBoard.array[i][j].shape ?? colors.count - 1
        button.backgroundColor = colors[number]
    }
    
    func setButtonColors() {
        for i in 0 ..< buttons.count {
            for j in 0 ..< buttons[i].count {
                setColorFor(button: buttons[i][j], i: i, j: j)
            }
        }
    }
    
    func setColorForSquares(set squares: Set<Square>) {
        for square in squares {
            let row = square.row
            let column = square.column
            setColorFor(button: buttons[row][column], i: row, j: column)
        }
    }
    

    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "selectPlayerSegue" else { return }
        let vc = segue.destination as! PlayerSelectionTableViewController
        vc.delegate = self
        vc.player = self.player
    }
    
    // MARK: Defining Colors
    var colors = [
        UIColor(red: 255/255, green: 30/255, blue: 30/255, alpha: 1), //main red
        UIColor(red: 199/255, green: 242/255, blue: 113/255, alpha: 1), //light green
        UIColor(red: 25/255, green: 48/255, blue: 122/255, alpha: 1), //dark blue
        UIColor(red: 198/255, green: 66/255, blue: 140/255, alpha: 1), //medium pink
        UIColor(red: 34/255, green: 4/255, blue: 57/255, alpha: 1), //dark violet hello
        
        UIColor(red: 68/255, green: 91/255, blue: 167/255, alpha: 1), //medium blue
        UIColor(red: 32/255, green: 205/255, blue: 221/255, alpha: 1), //cyan ish
        UIColor(red: 66/255, green: 197/255, blue: 66/255, alpha: 1), //medium green
        UIColor(red: 83/255, green: 43/255, blue: 114/255, alpha: 1), //medium violet hello
        UIColor(red: 247/255, green: 196/255, blue: 82/255, alpha: 1), //medium yellow
        
        UIColor(red: 51/255, green: 142/255, blue: 150/255, alpha: 1), // medium cyan?
        UIColor(red: 148/255, green: 118/255, blue: 171/255, alpha: 1), //light violet hello
        UIColor(red: 148/255, green: 164/255, blue: 218/255, alpha: 1), //light blue
        UIColor(red: 255/255, green: 127/255, blue: 21/255, alpha: 1), //orangeish
        UIColor(red: 232/255, green: 148/255, blue: 196/255, alpha: 1), //light pink
        
        UIColor.white
    ]
    
    
}

extension MainGameViewController: SlidingTileBoardDelegate {
    func slidingTileGameOver() {
        let alertController = UIAlertController(title: "You Won!", message: "Congrats! 🎉\nYou won in \(tileBoard.moves) moves", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func squaresMoved(old: [Square], new: [Square]) {
        let both : [Square] = old + new
        let bothSet = Set<Square>(both)
        setColorForSquares(set: bothSet)
    }
}

extension MainGameViewController : PlayerSelectionDelegate {
    func didSelect(_ player: Player?) {
        if let player = player {
            self.player = player
            playerSelectionButton.title = self.player?.stringValue
            playButton.isEnabled = true
        } else {
            playButton.isEnabled = false
        }
    }
}
