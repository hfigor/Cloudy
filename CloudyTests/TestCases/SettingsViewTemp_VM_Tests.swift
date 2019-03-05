//
//  SettingsViewTemp_VM_Tests.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/5/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsViewTemp_VM_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
    }
    
    // MARK: Tests for Text
    
    func testText_Fahrenheit() {
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
    
        XCTAssertEqual(viewModel.text, "Fahrenheit")
    }
    
    func testText_Celsius() {
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        
        XCTAssertEqual(viewModel.text, "Celcius")
    }
    
    // MARK: Tests for Accessory Type
    
    func testAccessoryType_Fahrenheit_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.setTemperatureNotation(temperatureNotation: temperatureNotation)
        
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }

    func testAccessoryType_Fahrenheit_Celsius() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.setTemperatureNotation(temperatureNotation: temperatureNotation)
        
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }

    func testAccessoryType_Celsius_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.setTemperatureNotation(temperatureNotation: temperatureNotation)
        
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }
    
    func testAccessoryType_Celsius_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.setTemperatureNotation(temperatureNotation: temperatureNotation)
        
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
