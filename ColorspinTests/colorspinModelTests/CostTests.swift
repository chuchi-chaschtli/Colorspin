//
//  CostTests.swift
//  colorspinModelTests
//
//  Created by Anand Kumar on 8/2/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class CostTests: XCTestCase {

    func testCostEquatable() {
        let cost1 = Cost(stars: 1, coins: 3)
        let cost2 = Cost(stars: 1, coins: 2)

        XCTAssertFalse(cost1 == cost2)
        XCTAssertTrue(cost1 == cost1)
    }

    func testCostSetup() {
        let cost = Cost(stars: 1, coins: 4)

        XCTAssertEqual(cost.stars, 1)
        XCTAssertEqual(cost.coins, 4)
    }

    func testCostFromJson() {
        let json: JSON = [
            "stars": 3,
            "coins": 4
        ]
        let cost = try? Cost(json: json)

        XCTAssertNotNil(cost)
        XCTAssertEqual(cost?.stars, 3)
        XCTAssertEqual(cost?.coins, 4)
    }

    func testBadJson() {
        let json: JSON = [
            "stars": false,
            "coins": 2
        ]
        let cost = try? Cost(json: json)

        XCTAssertNil(cost)
    }
}
