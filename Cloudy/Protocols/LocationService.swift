//
//  LocationService.swift
//  Cloudy
//
//  Created by Frank Cipolla on 3/21/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

protocol LocationService {
    
    typealias LocationServiceCompletionHandler = ([Location], Error?) -> Void
    
    func geocode(addressString: String?, completionHandler: @escaping LocationServiceCompletionHandler)
}
