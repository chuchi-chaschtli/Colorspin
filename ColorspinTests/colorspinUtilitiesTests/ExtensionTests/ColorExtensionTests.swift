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

    func testColorFromHTMLFriendlyName() {
        XCTAssertNotNil(UIColor(name: "red"))
        XCTAssertEqual(UIColor(name: "red"), .red)
    }

    func testColorFromHTMLFriendlyNameGetsFormattedAppropriately() {
        XCTAssertNotNil(UIColor(name: "R E d"))
        XCTAssertEqual(UIColor(name: "R E d"), .red)
    }

    func testColorFromInvalidNameIsNil() {
        XCTAssertNil(UIColor(name: "ayy lmao"))
    }

    func testColorParsesGreyToGray() {
        XCTAssertNotNil(UIColor(name: "grey"))
        XCTAssertEqual(UIColor(name: "grey"), UIColor(name: "gray"))
    }
}
