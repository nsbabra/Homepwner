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

    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}
