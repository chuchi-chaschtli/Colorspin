//
//  DoubleExtensionTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class DoubleExtensionTests: XCTestCase {

    func testForceInRange() {
        XCTAssertEqual(5.02.clamp(1, 4), 4)
        XCTAssertEqual(5.02.clamp(5, 9), 5.02)
        XCTAssertEqual(5.02.clamp(5.02, 4), 5.02)
        XCTAssertEqual(5.02.clamp(4, 5.02), 5.02)
        XCTAssertEqual(5.02.clamp(9, 5), 5.02)
        XCTAssertEqual(0.clamp(9, 5), 5)
        XCTAssertEqual(0.clamp(-1, 1), 0)
    }
}
