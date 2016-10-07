//
//  ListViewController.swift
//  Photos
//
//  Created by Ezequiel on 06/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit

extension ListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.photoViewModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = manager.photoViewModels[indexPath.row].title
        return cell
    }
    
}
