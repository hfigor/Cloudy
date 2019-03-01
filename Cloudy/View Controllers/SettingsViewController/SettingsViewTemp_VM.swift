//
//  SettingsViewTemp_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/26/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

struct SettingsViewTemperatureViewModel {
    // MARK: Properties
    
    let temperatureNotation: TemperatureNotation
    
    var text: String {
        switch temperatureNotation {
        case .fahrenheit:
            return  "Fahrenheit"
        case .celsius:
            return  "Celcius"
        }
    }
    
    
    var accessoryType: UITableViewCellAccessoryType {
        if UserDefaults.temperatureNotation() == temperatureNotation {
            return .checkmark
        } else {
            return .none
        }
    }
}
