//
//  SettingsRepresentable.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/1/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    
    var text: String {get}
    
    var accessoryType: UITableViewCellAccessoryType {get}
    
}
