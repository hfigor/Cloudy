//
//  WeekView_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/19/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import Foundation

struct WeekViewModel {
    
// MARK Properties
    
let weatherData: [WeatherDayData]

    private let dayFormatter = DateFormatter()
    private let dateFormatter = DateFormatter()
    
    
var numberOfSections: Int {
    return 1
}

var numberOfDays: Int {  // actually the number of rows in the section
    return weatherData.count
}
    
    // MARK : Support day label of WeatherDataTableViewCell
    
    func day(for index: Int) -> String {
        let weatherDayData = weatherData[index]
        
         // Configure Data Formatter
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    func date(for index: Int) -> String {
        // Fetch Weather Data for Day
        let weatherDayData = weatherData[index]
        
        // Configure Date Formatter
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    // MARK: Support for the Temperature label for the WeatherDayTableViewCell
    
    func temperature(for index: Int) -> String {
        // Fetch Weather Data
        let weatherDayData = weatherData[index]
        
        let min = format(temperature: weatherDayData.temperatureMin)
        let max = format(temperature: weatherDayData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    // MARK: Temperature Helper Methods
    
    private func format(temperature: Double) -> String {
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.0f F", temperature)
        case .celsius:
            return String(format: "%.0f C", temperature.toCelcius())
        }
    }
    
    // MARK: Support for Windspeed label
    
    func windSpeed(for index: Int) -> String {
        
        // Fetch Weather Data
        let weatherDayData = weatherData[index]
        let windSpeed = weatherDayData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format:" %.f MPH", windSpeed)
        case .metric:
            return String(format:" %.f KPH", windSpeed.toKPH())
        }
      }
        // MARK: Support for icon image
    
    func iconImageName(for index: Int) -> String {
        // Fetch Weather Data
        let weatherDayData = weatherData[index]
        return weatherDayData.icon
    }
    
    
    
   
}
