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
    }

    // MARK: Tests for Date
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Tue, July 11")
    }

    // MARK: Tests for Time
    
    func testTime_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.setTimeNotation(timeNotation: timeNotation)
        
        XCTAssertEqual(viewModel.time, "01:57 PM")
    }
    
    func testTime_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.setTimeNotation(timeNotation: timeNotation)
        
        XCTAssertEqual(viewModel.time, "13:57")
    }
    
    func testTimeYwentyfourHour() {
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
