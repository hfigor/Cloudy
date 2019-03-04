//
//  DayView_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/15/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

struct DayViewModel {
    
    // MARK: - Properties
   
    let weatherData: WeatherData // Remember that the view model should keep a reference to the model
    
    // MARK: Support For Date Label
    private let dateFormatter = DateFormatter()
    
     var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEE, MMMM d"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    // MARK: Support For Time Label
    private let timeFormatter = DateFormatter()
    
    var time: String {
        // Configure Date Formatter
        timeFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
        
        return timeFormatter.string(from: weatherData.time)
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
            return String(format: "%.1f ℉", temperature)
        case .celsius:
            return String(format: "%.1f ℃", temperature.toCelcius())
        }
    }
    
    // MARK Suppoer for Windspeed Label
    
    var windspeed: String {
        let windspeed = weatherData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f \u{00B0} MPH", windspeed)
        case .metric:
            return String(format: "%.f  KPH", windspeed.toKPH())
        }
    }
    // MARK: Support for icon Image
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherData.icon)
    }

}
