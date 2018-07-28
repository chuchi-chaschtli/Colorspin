//
//  ArrayExtensionTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class ArrayExtensionTests: XCTestCase {

    func testSeparate() {
        let array: [Any] = [1, "hello", 2.5, "world", true, false]
        
        let separated = array.separate { (element) -> Bool in
            element is String
        }
    
        XCTAssertTrue(separated.matching is [String])
        XCTAssertEqual(separated.matching as? [String], ["hello", "world"])
        XCTAssertEqual(separated.notMatching[0] as? Int, 1)
        XCTAssertEqual(separated.notMatching[1] as? Double, 2.5)
        XCTAssertTrue(separated.notMatching[2] as? Bool ?? false)
        XCTAssertFalse(separated.notMatching[3] as? Bool ?? true)
    }
    
    func testMutableForEach() {
        var array: [Int] = [1, 2, 5, 7, 100]
        
        array.mutateEach { (value) in
            value *= 2
        }
        
        XCTAssertNotNil(array)
        XCTAssertEqual(array.count, 5)
        XCTAssertEqual(array[0], 2)
        XCTAssertEqual(array[1], 4)
        XCTAssertEqual(array[2], 10)
        XCTAssertEqual(array[3], 14)
        XCTAssertEqual(array[4], 200)
    }
}
