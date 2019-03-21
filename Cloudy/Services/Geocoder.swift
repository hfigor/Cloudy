//
//  Geocoder.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/21/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import CoreLocation

class Geocoder: LocationService {
    
    // MARK: Properties
    
    private lazy var geocoder = CLGeocoder()
    
    func geocode(addressString: String?, completionHandler: @escaping LocationService.LocationServiceCompletionHandler) {
        guard let addressString = addressString else {
         completionHandler([], nil)
            return
        }
        
        // Geocode Address String
        geocoder.geocodeAddressString(addressString, completionHandler: { (placemarks, error) in
            if let error = error {
                completionHandler([], error)
                print("Unable to Forward Geocode Address (\(error))")
            } else if let _placemarks = placemarks {
                // update locations
                let locations = _placemarks.compactMap({(placemark) -> Location? in
                    guard let name = placemark.name else { return nil}
                    guard let location = placemark.location else { return nil }
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
               completionHandler(locations, nil)
            }
        })
    }
}
