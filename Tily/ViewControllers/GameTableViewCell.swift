//
//  GameTableViewCell.swift
//  Tily
//
//  Created by Majd Koshakji on 10/6/19.
//  Copyright © 2019 Majd Koshakji. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setup(with tileBoard: SlidingTileBoard) {
        self.titleLabel.text = tileBoard.name
        
        var squares = [[UIView]]()
        for view in mainStackView.arrangedSubviews {
            mainStackView.removeArrangedSubview(view)
        }
        
        for i in 0 ..< tileBoard.height {
            squares.append([])
            for j in 0 ..< tileBoard.width {
                let view = UIView()
                
                MainGameViewController.setColorFor(tileBoard: tileBoard, button: view, i: i, j: j)

                squares[i].append(view)
            }
            let lineStackView = UIStackView(arrangedSubviews: squares[i])
            lineStackView.alignment = .fill
            lineStackView.distribution = .fillEqually
            lineStackView.axis = .horizontal
            mainStackView.addArrangedSubview(lineStackView)
        }
    }

}
