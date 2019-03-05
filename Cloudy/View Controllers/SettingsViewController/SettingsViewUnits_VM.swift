//
//  SettingsViewUnits_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/25/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

struct SettingsViewUnitsViewModel {
    
    // Mark: Properties
    
    let unitsNotation: UnitsNotation
    
    var text: String {
        switch unitsNotation {
        case .imperial:
            return  "Imperial"
        case .metric:
            return   "Metric"
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        if UserDefaults.unitsNotation() == unitsNotation {
            return .checkmark
        } else {
            return .none
        }
    }
}

extension  SettingsViewUnitsViewModel: SettingsRepresentable {
    
}
