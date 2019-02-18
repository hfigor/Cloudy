//
//  DayView_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/15/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

struct DayViewModel { // Remember that the view model should keep a reference to the model
    
    // MARK: - Properties
    
    let weatherData: WeatherData
    
    // MARK: Support For Date Label
    
    var date: String {
        
        // Initialize Date Formatter
        
        let dateFormatter = DateFormatter()
        
        // Configure Data Formatter
        
        dateFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
        
        return dateFormatter.string(from:weatherData.time)
    }
    
    // MARK: Support for Description Label
    
    var summary: String {
        
        return weatherData.summary
    }
    
    // MARK: Support For Temperature Label
    
    var temperature: String {
        
        let temperature = weatherData.temperature
        
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.1f F", temperature)
        case .celsius:
            return String(format: "%.1f C", temperature)
        }
    }
    
    // MARK Suppoer for Windspeed Label
    
    var windspeed: String {
        let windspeed = weatherData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windspeed)
        case .metric:
            return String(format: "%.f KPH", windspeed.toKPH())
        }
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherData.icon)
    }
}
