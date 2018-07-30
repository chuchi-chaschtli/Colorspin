//
//  DictionaryExtensionTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class DictionaryExtensionTests: XCTestCase {

    func testDictionaryUpdateAddsNewKeyValues() {
        let dict: [String: Int] = ["a": 1, "b": 2]
        XCTAssertEqual(dict.update(with: ["c": 3, "d": 4]), ["a": 1, "b": 2, "c": 3, "d": 4])
    }

    func testDictionaryUpdateOverridesExistingKeys() {
        let dict: [String: Int] = ["a": 1, "b": 3]
        XCTAssertEqual(dict.update(with: ["b": 2]), ["a": 1, "b": 2])
    }
}
