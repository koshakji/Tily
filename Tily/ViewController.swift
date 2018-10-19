//
//  ViewController.swift
//  Tily
//
//  Created by Majd Koshakji on 10/16/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {

    var colors = [
        UIColor(red: 255/255, green: 30/255, blue: 30/255, alpha: 1), //main red
        UIColor(red: 199/255, green: 242/255, blue: 113/255, alpha: 1), //light green
        UIColor(red: 25/255, green: 48/255, blue: 122/255, alpha: 1), //dark blue
        UIColor(red: 198/255, green: 66/255, blue: 140/255, alpha: 1), //medium pink
        UIColor(red: 34/255, green: 4/255, blue: 57/255, alpha: 1), //dark violet hello

        UIColor(red: 68/255, green: 91/255, blue: 167/255, alpha: 1), //medium blue
        UIColor(red: 247/255, green: 82/255, blue: 82/255, alpha: 1), //medium red
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
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var viewTitle: UINavigationItem!
    
    var tileBoard : SlidingTileBoard!
    var buttons = [[UIButton]]()
    var count = 0
    var shape : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tileBoard.delegate = self
        
        viewTitle.title = tileBoard.name
        let dismissItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(exitGame))
        viewTitle.rightBarButtonItem = dismissItem
        
        clearerColors(except: colors.count - 1, alpha: 1)
        
        for i in 0 ..< tileBoard.height {
            buttons.append([])
            for j in 0 ..< tileBoard.width {
                let button = UIButton()
                //setTitleFor(button: button, i: i, j: j)
                setColorFor(button: button, i: i, j: j)
                button.setTitleColor(UIColor.black, for: .normal)
                button.tag = i * tileBoard.width + j
                button.addTarget(self, action: #selector(tappedAt(_:)), for: .primaryActionTriggered)
                button.translatesAutoresizingMaskIntoConstraints = false
                buttons[i].append(button)
            }
            let lineStackView = UIStackView(arrangedSubviews: buttons[i])
            lineStackView.translatesAutoresizingMaskIntoConstraints = false
            lineStackView.alignment = .fill
            lineStackView.distribution = .fillEqually
            lineStackView.axis = .horizontal
            mainStackView.addArrangedSubview(lineStackView)
        }
    }
    
    @objc func tappedAt(_ sender: UIButton) {
        let location = getIandJ(from: sender.tag)
        shape = tileBoard.array[location.i][location.j].shape
        if let colorNumber = shape {
            clearerColors(except: colorNumber)
        } else {
            clearerColors(except: colors.count - 1, alpha: 1)
        }
        setButtonColors()
    }
    
    @objc func exitGame() {
        self.dismiss(animated: true, completion: nil)
    }

    func getIandJ(from value: Int) -> (i: Int, j: Int) {
        let row : Int = value / tileBoard.width
        let column: Int = value % tileBoard.width
        return (row,column)
    }
    
    func setTitleFor(button: UIButton, i: Int, j: Int) {
         button.setTitle("\(tileBoard.array[i][j].shape ?? -1)", for: .normal)
    }
    func setColorFor(button: UIButton, i: Int, j: Int) {
        let number = tileBoard.array[i][j].shape ?? colors.count - 1
        button.layer.backgroundColor = colors[number].cgColor
    }
    
    func setButtonColors() {
        for i in 0 ..< buttons.count {
            for j in 0 ..< buttons[i].count {
                //setTitleFor(button: buttons[i][j], i: i, j: j)
                setColorFor(button: buttons[i][j], i: i, j: j)
            }
        }
    }
    
    func clearerColors(except colorNumber: Int, alpha: CGFloat = 0.4) {
        colors = colors.map { $0.withAlphaComponent(alpha) }
        colors[colorNumber] = colors[colorNumber].withAlphaComponent(1)
    }
    
    @IBAction func rightSwipe(_ sender: Any) {
        moveShapeIn(direction: .Right)
    }
    @IBAction func leftSwipe(_ sender: Any) {
        moveShapeIn(direction: .Left)
    }
    @IBAction func upSwipe(_ sender: Any) {
        moveShapeIn(direction: .Up)
    }
    @IBAction func downSwipe(_ sender: Any) {
        moveShapeIn(direction: .Down)
    }
    
    func moveShapeIn(direction: Direction) {
        guard let shape = self.shape else { return }
        tileBoard.move(shape: shape, direction)
        setButtonColors()
    }
    
}

extension MainGameViewController: SlidingTileBoardDelegate {
    func slidingTileGameOver() {
        let alertController = UIAlertController(title: "You Won!", message: "congrats! 🎉", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
            return
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
