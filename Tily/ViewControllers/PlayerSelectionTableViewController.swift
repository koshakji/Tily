//
//  PlayerSelectionTableViewController.swift
//  Tily
//
//  Created by Majd Koshakji on 10/31/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import UIKit

protocol PlayerSelectionDelegate {
    func didSelect(_ player: Player?)
}

class PlayerSelectionTableViewController: UITableViewController {
    
    let players: [Player] = [otherDFSPlayer(), otherBFSPlayer(), otherUCSPlayer(), otherHillClimbingPlayer(), otherAStarPlayer()]
    var player : Player?
    var delegate : PlayerSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        let playa = players[indexPath.row]
        cell.textLabel?.text = playa.stringValue
        
        if let player = self.player {
            if playa.stringValue == player.stringValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        player = players[indexPath.row]
        delegate?.didSelect(player)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
