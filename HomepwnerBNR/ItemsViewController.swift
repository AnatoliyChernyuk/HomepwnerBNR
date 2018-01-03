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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if itemStore.allItems.isEmpty {
            return 1
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if itemStore.allItems.isEmpty {
            return nil
        }
        switch section {
        case 0:
            return "Items Worth Less Then $50"
        case 1:
            return "Items Worth More Then $50"
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemStore.allItems.isEmpty {
            return 1
        }
        switch section {
        case 0:
            return filterItemsIn(store: itemStore.allItems, greaterThen50: false).count
        case 1:
            return filterItemsIn(store: itemStore.allItems, greaterThen50: true).count
        case 2:
            return 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let image = UIImage(named: "LandscapeBackground")!
        cell.backgroundColor = UIColor(patternImage: image)
        
        if itemStore.allItems.isEmpty || indexPath.section == 2 {
            cell.textLabel?.text = "No more items!"
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.text = nil
            return cell
        }
        let item: Item
        switch indexPath.section {
        case 0:
            let newStore = filterItemsIn(store: itemStore.allItems, greaterThen50: false)
            item = newStore[indexPath.row]
        case 1:
            let newStore = filterItemsIn(store: itemStore.allItems, greaterThen50: true)
            item = newStore[indexPath.row]
        default:
            item = Item()
        }
        
        cell.textLabel?.text = item.name
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.detailTextLabel?.text = String(item.valueInDollars)
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if itemStore.allItems.isEmpty || indexPath.section == 2 {
            return 44
        } else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if itemStore.allItems.isEmpty || section == 2 {
            return 0
        } else {
            return 60
        }
    }
    
    func filterItemsIn(store: [Item], greaterThen50: Bool) -> [Item] {
        var newStore = [Item]()
        if greaterThen50 == true {
            for item in store {
                if item.valueInDollars > 50 {
                    newStore.append(item)
                }
            }
        } else {
            for item in store {
                if item.valueInDollars <= 50 {
                    newStore.append(item)
                }
            }
        }
        return newStore
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
