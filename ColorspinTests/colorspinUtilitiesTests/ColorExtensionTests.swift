//
//  ColorExtensionTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class ColorExtensionTests: XCTestCase {

    func testColorDictionarySetup() {
        XCTAssertNotNil(UIColor.stringsToColors)
        XCTAssertTrue(UIColor.stringsToColors.count > 0)
        XCTAssertEqual(UIColor.stringsToColors["red"], .red)
    }
}
