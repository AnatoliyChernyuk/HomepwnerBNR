//
//  ItemStore.swift
//  HomepwnerBNR
//
//  Created by Anatoliy Chernyuk on 1/2/18.
//  Copyright © 2018 Anatoliy Chernyuk. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    var greaterThen50: [Item] {
        return allItems.filter{$0.valueInDollars > 50}
    }
    var lessOrEqualTo50: [Item] {
        return allItems.filter{$0.valueInDollars <= 50}
    }
    
    init() {
        var items = [Item]()
        for _ in 0..<5 {
            items.append(createItem())
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    //Mine solution to the challenges
    /*
    func filterItemsIn(store: [Item], greaterThen50: Bool) -> [Item] {
        var newStore = [Item]()
        if greaterThen50 == true {
            newStore = allItems.filter{$0.valueInDollars>50}
        } else {
            newStore = allItems.filter{$0.valueInDollars<=50}
        }
        return newStore
    }
    */
}
