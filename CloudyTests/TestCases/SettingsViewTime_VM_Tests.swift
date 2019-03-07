//
//  SettingsViewTime_VM_Tests.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/4/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy


class SettingsViewTime_VM_Tests: XCTestCase {
    
    // Mark: Setup and Tear Down
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
    }
    
    // MARK: Text 12 and 24 hour tests
    func testText_TwelveHour() {
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twelveHour)
        XCTAssertEqual(viewModel.text, "12 Hour")
    }
    
    func testText_TwentyFourHour() {
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twentyFourHour)
        XCTAssertEqual(viewModel.text, "24 HOur")
    }
    
    // MARK: Accessory Type Tests
    
    func testAccessoryType_TwelveHour_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        
        let viewModel = SettingsViewTimeViewModel(timeNotation:.twelveHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }
    
    func testAccessoryType_TwelveHour_TwentyFourHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        
        let viewModel = SettingsViewTimeViewModel(timeNotation:.twentyFourHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
    func testAccessoryType_TwentyFourHour_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        
        let viewModel = SettingsViewTimeViewModel(timeNotation:.twentyFourHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }
    
    func testAccessoryType_TwentyFourHour_TwelveHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        
        let viewModel = SettingsViewTimeViewModel(timeNotation:.twelveHour)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
