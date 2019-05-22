//
//  SwipeTableVC.swift
//  gotta
//
//  Created by Lahari Ganti on 2/11/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableVC: UITableViewController, SwipeTableViewCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "customCell")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }


    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)

        }
        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }

    func updateModel(at indexPath: IndexPath) {

    }
}
