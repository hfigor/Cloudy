//
//  ReusableView.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/27/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

protocol ReuseableView {
    static var reuseIdentifier: String{ get }
}

// take it one step further by providing a default implementation using an extension.
extension ReuseableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// Any type conforming to the ReusableView protocol has a static property named reuseIdentifier.
// Because we provided a default implementation for the reuseIdentifier property, we can leave the implementation of the extension empty.
extension UITableViewCell: ReuseableView {}
