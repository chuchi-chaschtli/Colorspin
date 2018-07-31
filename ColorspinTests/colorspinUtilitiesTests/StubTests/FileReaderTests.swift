//
//  FileReaderTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class FileReaderTests: XCTestCase {

    func testFileParseSucceeds() {
        var data: Data?
        var parseError: Error?
        do {
            data = try FileReader.read("level")
        } catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(data)
    }

    func testFileNotFoundThrowsError() {
        var parseError: Error?
        do {
            _ = try FileReader.read("yooooo fake file!")
        } catch let error {
            parseError = error
        }

        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? FileParseError, .notFound)
    }
}
