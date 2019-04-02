//
//  UITableView.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/28/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

extension UITableView {
    //The goal is to ask a table view for a reusable table view cell by providing nothing more than an index path.
    func dequeueReusableCell<T: UITableViewCell>(for indexpath: IndexPath) -> T {
        // Because T needs to inherit from UITableViewCell and UITableViewCell conforms to the ReusableView protocol,
        // we can ask it for its reuse identifier by accessing the value of its reuseIdentifier property. 
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexpath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}

