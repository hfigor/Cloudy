//
//  XCTestCase.swift
//  CloudyTests
//
//  Created by Frank Cipolla on 3/5/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import XCTest

extension XCTestCase {

// In loadStubFromBundle(withName:extension:), we fetch a reference to the unit testing bundle, ask it for the URL of the file we're interested in, and use the URL to instantiate a Data instance.

func loadStubFromBundle(withName name: String, extension: String) -> Data {
    let bundle = Bundle(for: classForCoder)
    let url = Bundle.url(forResource: name, withExtension: `extension`)
 
    return try! Data(contentsOf: url!)
    // from https://cocoacasts.com/using-stubs-for-better-unit-tests :
    // we're only interested in the results of the unit tests. If anything else goes wrong, we made a silly mistake, which we need to fix. In other words, I'm not interested in error handling or safety when writing and running unit tests.
}

}
