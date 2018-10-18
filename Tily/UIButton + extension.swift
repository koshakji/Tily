//
//  UIButton + extension.swift
//  Tily
//
//  Created by Majd Koshakji on 10/18/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func addBorder(side: Direction, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Up:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Down:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
}
