//
//  WeatherDayView_VM_Tests.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/7/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeatherDayView_VM_Tests: XCTestCase {

    // MARK: Properies
    
    var viewModel: WeatherDayViewViewModel!
    
    override func setUp() {
        super.setUp()
        
        // MARK: Load the Weather Data Stub
        let data = loadStubFromBundle(withName: "darksky", extension: "json")
        let weatherData: WeatherData = try! JSONDecoder.decode(data:data)
        
        // Initialize View Model
        viewModel = WeatherDayViewViewModel(weatherDayData: weatherData.dailyData[5])
    }

    override func tearDown() {
       super.tearDown()
        
        // Mark: Reset User Defaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
    }

   // MARK: Test for Day
    func testDay() {
        XCTAssertEqual(viewModel.day, "Saturday")
    }

    // MARK: Test for Date
    func testDate() {
        XCTAssertEqual(viewModel.date, "Jul 15")
    }
    
    // MARK: Tests for Temperature
    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)

        XCTAssertEqual(viewModel.temperature, "37 F - 47 F")
    }

    // MARK: Test for Celsius
    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)

        XCTAssertEqual(viewModel.temperature, "3 C - 8 C")
    }

    // MARK: Tests for Wind Speed
    func testWindSpeed_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windspeed, " 1 MPH")
    }

    func testWindSpeed_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windspeed, " 2 KPH")
    }
    
    // Tests for Image
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "cloudy")!.pngData()!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 236.0)
        XCTAssertEqual(viewModelImage!.size.height, 172.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
            
        }

}
