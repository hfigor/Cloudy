//
//  DayView_VM_Tests.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/5/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class DayView_VM_Tests: XCTestCase {

    // MARK: Properties
    
    // from https://cocoacasts.com/using-stubs-for-better-unit-tests :
    // To simplify the unit tests, we won't be instantiating a view model in each of the unit tests. Instead, we create a view model, the view model we use for testing, in the setUp() method. Let me show you how that works and what the benefits are.
    
    var viewModel: DayViewModel!
    
    override func setUp() {
        super.setUp()
        
        // load stub weather data
        let data = loadStubFromBundle(withName: "darksky", extension: "json")
        let weatherData: WeatherData = try! JSONDecoder.decode(data: data)
        
        // initialize the View Model
        viewModel = DayViewModel(weatherData: weatherData)
    }

    override func tearDown() {
        super.tearDown()
        
        // MARK: Reset User Defaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
    }

    // MARK: Tests for Date
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Tue, July 11")
    }

    // MARK: Tests for Time
    
    func testTime_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.setTimeNotation(timeNotation: timeNotation)
        
        XCTAssertEqual(viewModel.time, "07:57 AM")
    }
    
    func testTime_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.setTimeNotation(timeNotation: timeNotation)
        
        XCTAssertEqual(viewModel.time, "07:57")
    }
    
    // MARK: Test Summary
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Clear")
    }
    
    // MARK: Tests for Temperature
    
    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "44.5 ℉")
    }
    
    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "6.9 ℃")
    }
    
    // MARK: Tests for Wind Speed
    
    func testWindspeed_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windspeed, "6 ° MPH")
    }
    
    func testWindspeed_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windspeed, "10  KPH")
    }
    
    // MARK: Tests for Image
    
    func testImage() {
        let viewModelImage = viewModel.image
        // get image reference and image reference name
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = viewModelImage!.pngData()!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 236.0)
        XCTAssertEqual(viewModelImage!.size.height, 236.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
