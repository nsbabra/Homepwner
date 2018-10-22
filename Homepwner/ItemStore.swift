//
//  ItemStore.swift
//  Homepwner
//
//  Created by Navneet Babra on 10/14/18.
//  Copyright © 2018 nsbabra. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()

    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)

        return newItem
    }

    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        } else {
            print("What item are you deleting silly boy!")
        }
    }

    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }

        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)

        allItems.insert(movedItem, at: toIndex)
    }
}
