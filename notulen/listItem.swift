//
//  listItem.swift
//  notulen
//
//  Created by Agust Lofianto on 4/4/16.
//  Copyright © 2016 xiang. All rights reserved.
//

import UIKit

var lists: ListItem = ListItem()

struct item {
    var desc = "description"
}

class ListItem: NSObject {
    var items = [item]()
    
    func addItem(descNew: String) {
        items.append(item(desc: descNew))
    }
    
    func rowItem() -> String {
        var result = ""
        var count = 1
        for item in items {
            print(item.desc)
            result = result + String(count) + ". " + item.desc + "\n"
            count = count + 1
        }
        return result
    }
    
    func delete() {
        items.removeAll()
    }
    
    func deleteAtIndex(index: Int) {
        items.removeAtIndex(index)
    }
}
