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

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        //Set text on the cell with item description that is at nth index of items,
        // where n = row this cell will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]

        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        let dollarValue = item.valueInDollars

        cell.valueLabel.textColor = (dollarValue < 50) ? UIColor.green : UIColor.red
        cell.valueLabel.text = "\(dollarValue)"

        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }

    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = itemStore.createItem()

        //Figure out where the item is, in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)

            //Insert row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)

            setEditing(false, animated: true)

        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove Me? Please don't!"
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let item = itemStore.allItems[indexPath.row]

            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            let deleteAction = UIAlertAction(title: "Delete ", style: .destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item)

                //Also remove the row from tableView
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })

            alertController.addAction(deleteAction)

            present(alertController, animated: true, completion: nil)

        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
