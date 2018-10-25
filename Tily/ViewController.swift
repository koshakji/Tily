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
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    
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
    
    @IBAction func setUCSPlayer(_ sender: Any) {
        player = UCSPlayer(tileBoard: tileBoard, delegate: self)
        playButton.isEnabled = true
    }
    
    @IBAction func setBFSPlayer(_ sender: Any) {
        player = BFSPlayer(tileBoard: tileBoard, delegate: self)
        playButton.isEnabled = true
    }
    
    @IBAction func setDFSPlayer(_ sender: Any) {
        player = DFSPlayer(tileBoard: tileBoard, delegate: self)
        playButton.isEnabled = true
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        if let player = player {
            player.play()
        } else {
            playButton.isEnabled = false
        }
    }
    
    // MARK: ViewModel
    func selectAndMoveShape(at button: UIView, to direction: Direction) {
        let location = getIandJ(from: button.tag)
        let shapeNumber = tileBoard.array[location.i][location.j].shape
        guard let shape = shapeNumber else { return }
        tileBoard.move(shape: shape, direction)
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

extension MainGameViewController: SimplePlayerDelegate {
    func switchedCurrentBoard(current: SlidingTileBoard) {
        self.tileBoard = current
        setButtonColors()
    }
}
