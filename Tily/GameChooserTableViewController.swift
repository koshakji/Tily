//
//  GameChooserTableViewController.swift
//  Tily
//
//  Created by Majd Koshakji on 10/18/18.
//  Copyright © 2018 Majd Koshakji. All rights reserved.
//

import UIKit

class GameChooserTableViewController: UITableViewController {

    let tileBoardFileManager = TileBoardFileManager()
    var games: [SlidingTileBoard]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games = tileBoardFileManager.read()
        
        //games = DefaultGameBuilder().games
        //tileBoardFileManager.save(games: games)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        let game = games[indexPath.row]
        cell.textLabel?.text = game.name
        return cell
    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loadGameSegue" {
            guard let mainGameVC = segue.destination as? MainGameViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            mainGameVC.tileBoard = games[indexPath.row]
        }
    }
}
