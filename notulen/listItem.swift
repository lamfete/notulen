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
}
