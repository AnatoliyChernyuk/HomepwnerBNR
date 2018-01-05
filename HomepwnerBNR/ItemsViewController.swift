//
//  ItemsViewController.swift
//  HomepwnerBNR
//
//  Created by Anatoliy Chernyuk on 1/2/18.
//  Copyright © 2018 Anatoliy Chernyuk. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //The best solution for the Chapter 11 Challenges is to use 2 sections from scratch. If the itemStore.allItems.isEmpty the number of rows in the first scetion is 0 making this section not visible on the screen. This approach removes the overhead of creating and deleting sections. Left it here as an example how to change the number of sections as it's a buggy process.
    override func numberOfSections(in tableView: UITableView) -> Int {
        if itemStore.allItems.isEmpty {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemStore.allItems.isEmpty || section == 1 {
            return 1
        } else {
            return itemStore.allItems.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if itemStore.allItems.isEmpty || indexPath.section == 1 {
            let noMoreItemsCell = UITableViewCell(style: .default, reuseIdentifier: "NoMoreItemsCell")
            noMoreItemsCell.textLabel?.text = "No more items!"
            noMoreItemsCell.detailTextLabel?.text = nil
            return noMoreItemsCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$" + String(item.valueInDollars)
        if item.valueInDollars < 50 {
            cell.valueLabel.textColor = UIColor.green
        } else {
            cell.valueLabel.textColor = UIColor.red
        }
        return cell
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = itemStore.createItem()
        if tableView.numberOfSections == 1 {
            tableView.insertSections(IndexSet(integer: 0), with: .automatic)
        } else {
            if let index = itemStore.allItems.index(of: newItem) {
                let indexPath = IndexPath(row: index, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            if itemStore.allItems.isEmpty {
                return
            }
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item)
                if self.itemStore.allItems.isEmpty {
                    self.tableView.deleteSections(IndexSet(integer: 0), with: .automatic)
                } else {
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        itemStore.moveItem(from: fromIndexPath.row, to: to.row)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView.numberOfSections == 1 || indexPath.section == 1 {
            return false
        }
        return true
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if tableView.numberOfSections == 1 || indexPath.section == 1 {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.section == 1 {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected Segue Identifier.")
        }
    }
}














































