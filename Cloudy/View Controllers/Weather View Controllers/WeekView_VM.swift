//
//  WeekView_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 2/19/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import Foundation

struct WeekViewModel {  // CH 13 We are going to use the WeatherDayViewViewModel to populate this view as well
    
    // MARK Properties
    
    let weatherData: [WeatherDayData]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {  // actually the number of rows in the section
        return weatherData.count
    }
    
    // MARK: methods
    
    // from https://cocoacasts.com/supercharging-mvvm-with-protocols :
    
    //    Because the week view view model is now responsible for supplying a view model for each table view cell of the week view controller,
    //    we need to implement a new method, viewModel(for:). This method takes an index as its only argument.
    //    The index corresponds with a row in the table view of the week view controller. The viewModel(for:) method returns an instance of the WeatherDayViewViewModel struct.
    
    //   We will use a protocol to pass this to the table view cell
    func viewModel(for index: Int) -> WeatherDayViewViewModel {
        return WeatherDayViewViewModel(weatherDayData: weatherData[index])
    }
}
