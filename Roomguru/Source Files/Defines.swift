//
//  Defines.swift
//  Roomguru
//
//  Created by Radoslaw Szeja on 12/03/15.
//  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: Types
// MARK: - Closures

typealias VoidBlock = Void -> Void
typealias ResponseBlock = (response: JSON?) -> Void
typealias ListResponseBlock = (response: [AnyObject]?) -> Void
typealias ErrorBlock = (error: NSError) -> Void
typealias DateBlock = (date: NSDate) -> Void
typealias StringBlock = (text: String) -> Void
typealias BoolBlock = (bool: Bool) -> Void

typealias DateValidationBlock = (date: NSDate) -> NSError?
typealias StringValidationBlock = (text: String) -> NSError?

// MARK: - Data types

typealias QueryParameters = [String: AnyObject]

// MARK: Reuse identifiers

let UITableViewCellReuseIdentifier = "RegularTableViewCellReuseIdentifier"
