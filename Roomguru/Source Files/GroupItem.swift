//
//  GroupItem.swift
//  Roomguru
//
//  Created by Radoslaw Szeja on 17/04/15.
//  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

protocol Updateable {
    func update()
}

class GroupItem: NSObject {
    
    enum Category {
        case Action, PlainText, LongText, Date, Picker, Boolean
        case None
    }
    
    let title: String
    let category: Category
    var selected: Bool = false
    
    init(title: String, category: Category) {
        self.title = title
        self.category = category
    }
}
