//
//  ViewController.swift
//  Tily
//
//  Created by Majd Koshakji on 10/16/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainStackView: UIStackView!
    
    let tileBoard = SlidingTileBoard(width: 4,height: 4)
    var buttons = [[UIButton]]()
    var count = 0
    var shape : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0 ..< tileBoard.height {
            buttons.append([])
            for j in 0 ..< tileBoard.width {
                let button = UIButton()
                setTitleFor(button: button, i: i, j: j)
                button.setTitleColor(UIColor.black, for: .normal)
                button.tag = i * tileBoard.width + j
                button.addTarget(self, action: #selector(tappedAt(_:)), for: .primaryActionTriggered)
                button.translatesAutoresizingMaskIntoConstraints = false
                buttons[i].append(button)
            }
            let lineStackView = UIStackView(arrangedSubviews: buttons[i])
            lineStackView.translatesAutoresizingMaskIntoConstraints = false
            lineStackView.alignment = .center
            lineStackView.distribution = .fillEqually
            lineStackView.axis = .horizontal
            mainStackView.addArrangedSubview(lineStackView)
        }
    }
    
    @objc func tappedAt(_ sender: UIButton) {
        let location = getIandJ(from: sender.tag)
        shape = tileBoard.array[location.i][location.j].shape
    }
    
    

    func getIandJ(from value: Int) -> (i: Int, j: Int) {
        let row : Int = value / tileBoard.width
        let column: Int = value % tileBoard.width
        return (row,column)
    }
    
    func setTitleFor(button: UIButton, i: Int, j: Int) {
         button.setTitle("\(tileBoard.array[i][j].shape ?? -1)", for: .normal)
    }
    
    func setButtonTitles() {
        for i in 0 ..< buttons.count {
            for j in 0 ..< buttons[i].count {
                setTitleFor(button: buttons[i][j], i: i, j: j)
            }
        }
    }
    
    @IBAction func rightSwipe(_ sender: Any) {
        moveShapeIn(direction: .right)
    }
    @IBAction func leftSwipe(_ sender: Any) {
        moveShapeIn(direction: .left)
    }
    @IBAction func upSwipe(_ sender: Any) {
        moveShapeIn(direction: .up)
    }
    @IBAction func downSwipe(_ sender: Any) {
        moveShapeIn(direction: .down)
    }
    
    func moveShapeIn(direction: Direction) {
        guard let shape = self.shape else { return }
        tileBoard.move(shape: shape, direction)
        setButtonTitles()
    }
    
}
