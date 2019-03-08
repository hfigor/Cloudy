//
//  WeatherDayView_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/2/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import UIKit

struct WeatherDayViewViewModel{

    // Properties
    
    let weatherDayData: WeatherDayData
    
    // NOTE:
    // Copied from WeekViewViewModel.swift
    // The difference is we do not fetch data from an array of models and use computed properties on the data feed
    
    private let dateFormatter = DateFormatter()
    
    var numberOfSections: Int {
        return 1
    }
    
//    var numberOfDays: Int {  // actually the number of rows in the section
//        return weatherData.count
//    }
    
    // MARK : Support labels of WeatherDataTableViewCell
    
    var day: String {
        // Configure Data Formatter
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    // Temperature
    var temperature: String {
        // Format min and max values
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
    
    var windspeed: String {
        
        let windSpeed = weatherDayData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format:" %.f MPH", windSpeed)
        case .metric:
            return String(format:" %.f KPH", windSpeed.toKPH())
        }
    }
    // MARK: Support for icon image
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherDayData.icon)
    }
}

extension WeatherDayViewViewModel: WeatherDayRepresentable {

}
