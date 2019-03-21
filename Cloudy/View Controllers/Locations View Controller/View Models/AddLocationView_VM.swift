//
//  AddLocationView_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/13/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation
// import CoreLocation // no longer needed. see location below

class AddLocationViewViewModel {
    
    // MARK: Initialization
    
    init(query: Driver<String>, locationService: LocationService) { // added locationService argument to support stubbing
        // Set Properties
        self.locationService = locationService
        
        query
        .throttle(0.5)
        .distinctUntilChanged()
            .drive(onNext: { [weak self] (addressString) in // The onNext handler is invoked when a new value is emitted by the sequence. 
                self?.geocode(addressString: addressString)
        })
        .disposed(by: disposeBag)
    }
    
    
    // MARK: Properties
    
    private let disposeBag = DisposeBag()
    
    // This VM will not manage state - RxSwift and RxCocoa keeps a reference to the stream of requests
    // see: https://cocoacasts.com/refactoring-the-view-model
    
    private let _locations = BehaviorRelay<[Location]>(value: [])
    private let _querying = BehaviorRelay<Bool>(value: false)
    
    var querying: Driver<Bool> { return _querying.asDriver() }
    var locations: Driver<[Location]> { return _locations.asDriver() }
    // The add location view controller no longer needs to know about the Core Location framework and it shouldn't perform the geocoding requests.
    // This is now handled by the view model.
   
    // private lazy var geocoder = CLGeocoder() replace with LocationService. This class no longer knows how the application performs the geocoding requests.
    // It could be the Core Location framework, but it might as well be some other library. Ref: https://cocoacasts.com/protocol-oriented-programming-and-dependency-injection
    private let locationService : LocationService
   
    // MARK: Notification Properties
    var queryingDidChange: ((Bool) -> ())?
    var locationsDidChange: (([Location]) -> ())?
    
    // MARK: Statefull Properties
    
    //    Notice that both properties are declared private.
    // Whenever the querying property is set, the closure stored in queryingDidChange is invoked
    // and the value of the querying property is passed in as an argument.
    
    //    The view controller doesn't need to know about these properties and it certainly shouldn't be able to modify the values of these properties.
    //    Instead, we define properties and methods the view controller can use to ask the view model for the data it needs to update its view.}
    var hasLocations: Bool { return numberOfLocations > 0 }
    var numberOfLocations: Int {return _locations.value.count}
    
  
    // Helper Methods
    
    // Because most of the heavy lifting is done by the location service, the geocode implementation is shorter and simpler.
    private func geocode(addressString: String?) {
        guard let addressString = addressString, addressString.count > 2 else {
            _locations.accept([])
            return
        }
        _querying.accept(true)
        
        // Geocode Address String
        locationService.geocode(addressString: addressString) { [weak self] (locations, error) in
            self?._querying.accept(false)
            self?._locations.accept(locations)
            
            if let error = error {
                print("Unable to Forward Geocode Address (\(error))")
            }
        }
    }
    
    
    func location(at index: Int) -> Location? {
        guard index < _locations.value.count else { return nil}
        return _locations.value[index]
    }
    
    func viewModelForLocation(at index: Int) -> LocationRepresentable? {
        guard let location = location(at: index) else { return nil}
        return LocationsViewLocationViewModel(location: location.location, locationAsString: location.name)
    }
}
