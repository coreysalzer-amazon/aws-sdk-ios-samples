//
//  PlaylistDetailViewController.swift
//  CognitoAuthSample
//
//  Created by Salzer, Corey on 1/3/18.
//  Copyright © 2018 Behroozi, David. All rights reserved.
//

import UIKit

class PlaylistDetailViewController: UITableViewController {
    
    var songs:[Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = songs[indexPath.row].name
        cell.detailTextLabel?.text = String(songs[indexPath.row].artist)
        
        return cell
    }
    
}
