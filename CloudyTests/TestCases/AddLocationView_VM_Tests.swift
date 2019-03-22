//
//  AddLocationView_VM_Tests.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/21/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import Cloudy



class AddLocationView_VM_Tests: XCTestCase {
    
    private class MockLocationsService: LocationService {
        func geocode(addressString: String?, completionHandler: @escaping LocationServiceCompletionHandler) {
            if let addressString = addressString, !addressString.isEmpty {
                // Create Location
                let location = Location(name: "Brussels", latitude: 50.8503, longitude: 4.3517)
                
                // Invoke Completion Handler
                completionHandler([location], nil)
            } else {
                // Invoke Completion Handler
                completionHandler([], nil)
            }
        }
        
    }
    
    // MARK: Properties
    
    var viewModel: AddLocationViewViewModel!
    
    var scheduler: SchedulerType!
    
    var query: BehaviorRelay<String>!
    
    // MARK: SetUp and TearDown
    
    override func setUp() {
        super.setUp()
        // initialize Query
        query = BehaviorRelay<String>(value: "")
        
        // Initialize Location Service
        let locationService = MockLocationsService()
        
        // Initialize View Model
        viewModel = AddLocationViewViewModel(query: query.asDriver(), locationService: locationService)
        
        // Initialize Scheduler
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests for Locations
    
    func testLocations_HasLocations() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Set Query
        query.accept("Brus")
        
        // Fetch Result
        let result = try! observable.skip(1).toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 1)
        
        // Fetch Location
        let location = result.first!
        XCTAssertEqual(location.name, "Brussels")
    }
    
    func testLocations_NoLocations() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Fetch Result
        let result: [Location] = try! observable.toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 0)
    }
    
    // MARK: Tests for Location At Index
    
    func testLocationAtIndex_NonNil() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Set Query
        query.accept("Brus")
        
        // Fetch result
        let _ = try! observable.skip(1).toBlocking().first()!
        
        // Fetch Location
        let result = viewModel.location(at: 0)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.name, "Brussels")
        
    }
    
    func testLocationAtIndex_Nil() {
        // Create Subscription
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        // Set Query
        query.accept("Brus")
        
        // Fetch result
        let _ = try! observable.skip(1).toBlocking().first()!
        
        // Fetch Location
        let result = viewModel.location(at: 1)
        
        XCTAssertNil(result)
    }
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
