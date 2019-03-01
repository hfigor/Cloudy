//
//  SettingsViewTime_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/22/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

struct SettingsViewTimeViewModel {
    
    // MARK: Properties
    
    let timeNotation: TimeNotation
    
    var text: String {
        switch timeNotation {
        case .twelveHour: return "12 Hour"
        case .twentyFourHour: return "24 HOur"
        }
    }
    
    var accessoryType: UITableViewCellAccessoryType {
        if UserDefaults.timeNotation() == timeNotation {
            return .checkmark
        } else {
            return .none
        }
    }
    
}
