//
//  StarTests.swift
//  colorspinModelTests
//
//  Created by Anand Kumar on 7/29/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class StarTests: XCTestCase {

    func testStarEquatable() {
        let star1 = Star(scoreToReach: 1, type: .bronze)
        let star2 = Star(scoreToReach: 1, type: .gold)

        XCTAssertFalse(star1 == star2)
        XCTAssertTrue(star1 == star1)
    }

    func testStarSetup() {
        let star = Star(scoreToReach: 1, type: .bronze)

        XCTAssertEqual(star.scoreToReach, 1)
        XCTAssertEqual(star.type, .bronze)
        XCTAssertEqual(star.type.color, UIColor(name: "bronze"))
    }

    func testStarFromJson() {
        let json: JSON = [
            "type": "gold",
            "scoreThreshold": 4
        ]
        let star = try? Star(json: json)

        XCTAssertNotNil(star)
        XCTAssertEqual(star?.scoreToReach, 4)
        XCTAssertEqual(star?.type, .gold)
        XCTAssertEqual(star?.type.color, UIColor(name: "gold"))
    }

    func testBadJson() {
        let json: JSON = [
            "type": false,
            "scoreThreshold": "yooo"
        ]
        let star = try? Star(json: json)

        XCTAssertNil(star)
    }
}
