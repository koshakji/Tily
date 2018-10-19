//
//  UIButton + extension.swift
//  Tily
//
//  Created by Majd Koshakji on 10/18/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorder(side: Direction, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Up:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Down:
            border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: frame.size.height)
        case .Right:
            border.frame = CGRect(x: frame.size.width - width, y: 0, width: width, height: frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
    func addBorders( sides: [Direction] = Array(Direction.allCases), color: UIColor = .black, width: CGFloat) {
        for side in sides {
            addBorder(side: side, color: color, width: width)
        }
    }
}
