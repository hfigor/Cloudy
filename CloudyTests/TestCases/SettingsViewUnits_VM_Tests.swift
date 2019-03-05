//
//  SettingsViewUnits_VM_Tests.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/4/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsViewUnitsViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
    }
    
    // MARK: Test for Text

    func testText_Imperial(){
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.text, "Imperial")
    }
    
    func testText_Metric() {
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        XCTAssertEqual(viewModel.text, "Metric")
    }

    // MARK: Test for Accessory Type
    
    func testAccessoryType_Imperial_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.setUnitsNotation(unitsNotation: unitsNotation)
        
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }
    
    func testAccessoryType_Imperial_Metric() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.setUnitsNotation(unitsNotation: unitsNotation)
        
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
    func testAccessoryType_Metric_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.setUnitsNotation(unitsNotation: unitsNotation)
        
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }
    
    func testAccessoryType_Metric_Imperial() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.setUnitsNotation(unitsNotation: unitsNotation)
        
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
//    func testPerformanceExample() {
//        
//       }
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
  

}
