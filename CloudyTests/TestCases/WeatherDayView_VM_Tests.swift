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
    
    var viewModel: WeekViewModel!
    
    override func setUp() {
        super.setUp()
        
        // MARK: Load the Weather Data Stub
        let data = loadStubFromBundle(withName: "darksky", extension: "json")
        let weatherData: WeatherData = try! JSONDecoder.decode(data:data)
        
        // Initialize View Model
        viewModel = WeekViewModel(weatherData: weatherData.dailyData)
    }

    override func tearDown() {
       super.tearDown()
    }

 
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
