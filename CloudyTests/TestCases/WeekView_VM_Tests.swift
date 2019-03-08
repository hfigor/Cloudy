//
//  WeekView_VM_Tests.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/7/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeekView_VM_Tests: XCTestCase {

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

    // MARK: Tests for Number of Sections
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }

    // MARK: Tests for Number of Days (rows)
    func testNumberOfDays() {
       XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    // MARK: func viewModel(for index: Int)
    func testViewModelForIndex() {
        let weatherDayViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weatherDayViewModel.day, "Saturday")
        XCTAssertEqual(weatherDayViewModel.date, "Jul 15")
    }
    
   
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
