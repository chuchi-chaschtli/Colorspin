//
//  UserDefaultsExtensionTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class UserDefaultsExtensionTests: XCTestCase {

    private let fixedLevels: [String: Int] = ["1": 2, "2": 1]

    override func setUp() {
        super.setUp()
        UserDefaults.clearData()
    }

    override func tearDown() {
        UserDefaults.clearData()
        super.tearDown()
    }

    func testClearDataRemovesUserDefaults() {
        UserDefaults.set(newLevels: fixedLevels)
        UserDefaults.set(coins: 30)
        UserDefaults.set(currentLevel: 20)

        UserDefaults.clearData()

        XCTAssertEqual(UserDefaults.coins, 0)
        XCTAssertEqual(UserDefaults.currentlevel, 0)
        XCTAssertEqual(UserDefaults.levels, [:])
    }

    func testSetCoinsUpdatesDefaults() {
        UserDefaults.set(coins: 30)

        XCTAssertEqual(UserDefaults.coins, 30)
    }

    func testSetLevelsUpdatesDefaults() {
        UserDefaults.set(newLevels: fixedLevels)

        XCTAssertEqual(UserDefaults.levels, fixedLevels)
    }

    func testSetCurrentLevelUpdatesDefaults() {
        UserDefaults.set(currentLevel: 30)

        XCTAssertEqual(UserDefaults.currentlevel, 30)
    }
}
