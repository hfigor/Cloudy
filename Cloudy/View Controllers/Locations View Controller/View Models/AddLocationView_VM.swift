//
//  AddLocationView_VM.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/13/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import Foundation
import CoreLocation

class AddLocationViewViewModel {
    
    // MARK: Properties
    
    // The add location view controller no longer needs to know about the Core Location framework and it shouldn't perform the geocoding requests.
    // This is now handled by the view model.
    private lazy var geocoder = CLGeocoder()
    
    var query: String = "" {
        didSet {
            geocode(addressString: query)
        }
    }
    
    // MARK: Notification Properties
    var queryingDidChange: ((Bool) -> ())?
    var locationsDidChange: (([Location]) -> ())?
    
    // MARK: Statefull Properties
    
    //    Notice that both properties are declared private.
    // Whenever the querying property is set, the closure stored in queryingDidChange is invoked
    // and the value of the querying property is passed in as an argument.
    private var querying: Bool = false {
        didSet {
            queryingDidChange?(querying)
        }
    }
    private var locations: [Location] = [] {
        didSet {
            locationsDidChange?(locations)
        }
    }
    
    //    The view controller doesn't need to know about these properties and it certainly shouldn't be able to modify the values of these properties.
    //    Instead, we define properties and methods the view controller can use to ask the view model for the data it needs to update its view.}
    var hasLocations: Bool { return numberOfLocations > 0 }
    var numberOfLocations: Int {return locations.count}
    
  
    // Helper Methods
    
    private func geocode(addressString: String?) {
        guard let addressString = addressString, !addressString.isEmpty else {
            locations = []
            return
        }
        querying = true
        // Geocode Address String
        geocoder.geocodeAddressString(addressString, completionHandler: { [weak self] (placemarks, error) in
            var locations: [Location] = []
            
            self?.querying = false
            if let error = error {
                print("Unable to Forward Geocode Address (\(error))")
            } else if let _placemarks = placemarks {
                locations = _placemarks.compactMap({(placemark) -> Location? in
                    guard let name = placemark.name else { return nil}
                    guard let location = placemark.location else { return nil }
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
            }
            self?.locations = locations
        })
    }
    
    
    func location(at index: Int) -> Location? {
        guard index < locations.count else { return nil}
        return locations[index]
    }
    
    func viewModelForLocation(at index: Int) -> LocationRepresentable? {
        guard let location = location(at: index) else { return nil}
        return LocationsViewLocationViewModel(location: location.location, locationAsString: location.name)
    }
}
