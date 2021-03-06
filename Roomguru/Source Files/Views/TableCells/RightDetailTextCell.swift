//
//  RightDetailTextCell.swift
//  Roomguru
//
//  Created by Radoslaw Szeja on 19/04/15.
//  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import Cartography
import FontAwesome_swift

class RightDetailTextCell: UITableViewCell, Reusable {
    
    class var reuseIdentifier: String {
        return "TableViewRightDetailTextCellReuseIdentifier"
    }
    
    var isRequired = false {
        didSet {
            invalidateIndentation()
            leftAccessoryLabel.hidden = !isRequired
        }
    }
    let detailLabel = UILabel()
    
    private var leftAccessoryLabel = UILabel()
    
    var validationError: NSError? {
        didSet {
            let isError = validationError != nil
            let fontAwesome: FontAwesome = isError ? .ExclamationCircle : .CheckCircle
            leftAccessoryLabel.textColor = isError ? .ngRedColor() : .ngGreenColor()
            leftAccessoryLabel.text = .fontAwesomeIconWithName(fontAwesome)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

private extension RightDetailTextCell {
    
    func commonInit() {
        leftAccessoryLabel = accessoryLabel()
        detailLabel.textAlignment = .Right
        contentView.addSubview(detailLabel)
        contentView.addSubview(leftAccessoryLabel)
        
        defineConstraints()
        invalidateIndentation()
    }
    
    func defineConstraints() {
        
        constrain(detailLabel) { detail in
            detail.right == detail.superview!.right
            detail.width == CGRectGetWidth(self.frame) * 0.6
            detail.centerY == detail.superview!.centerY
        }
        
        constrain(leftAccessoryLabel) { accessory in
            accessory.left == accessory.superview!.left + 10
            accessory.centerY == accessory.superview!.centerY
            accessory.width == 30
            accessory.height == 30
        }
    }
    
    func accessoryLabel() -> UILabel {
        let label = UILabel.roundedExclamationMarkLabel(CGRectMake(0, 0, 30, 30))
        label.hidden = true
        return label
    }
    
    func invalidateIndentation() {
        indentationLevel = isRequired ? 3 : 0
    }
}
