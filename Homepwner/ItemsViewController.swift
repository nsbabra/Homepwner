//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Navneet Babra on 10/14/18.
//  Copyright © 2018 nsbabra. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create an instance of UITableViewCell, with default appearance
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        //Set text on the cell with item description that is at nth index of items,
        // where n = row this cell will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]

        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"

        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
}
