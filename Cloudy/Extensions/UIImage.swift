//
//  UIImage.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/18/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageForIcon(withName name: String) -> UIImage? {
        switch name {
        case "clear-day", "clear-night", "rain", "snow", "sleet": return UIImage(named: name)
        case "wind","cloudy", "partly-cloudy-day", "partly-cloudy-night": return UIImage(named: "cloudy")
        default: return UIImage(named: "clear-day")
        }
    }
}
