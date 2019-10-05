//
//  AboutViewController.swift
//  Tily
//
//  Created by Majd Koshakji on 10/5/19.
//  Copyright © 2019 Majd Koshakji. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {
    
    let urls = [
        URL(string: "https://koshakji.github.io"),
        URL(string: "https://github.com/koshakji/tily"),
        URL(string: "https://github.com/raywenderlich/swift-algorithm-club")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let url = urls[indexPath.row] {
                UIApplication.shared.open(url)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
