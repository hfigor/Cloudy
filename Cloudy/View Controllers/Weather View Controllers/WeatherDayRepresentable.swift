//
//  WeatherDayRepresentable.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/3/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

protocol WeatherDayRepresentable {
    
    var day: String {get}
    var date: String {get}
    var image: UIImage? {get}
    var windspeed: String {get}
    var temperature: String {get}
}

