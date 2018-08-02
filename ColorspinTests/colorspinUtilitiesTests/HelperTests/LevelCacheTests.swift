//
//  LevelCacheTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class LevelCacheTests: XCTestCase {

    private let fixedLevels: [String: Int] = ["1": 3, "2": 1, "10": 2]

    override func setUp() {
        super.setUp()
        UserDefaults.clearData()
        UserDefaults.set(newLevels: fixedLevels)
        UserDefaults.set(coins: 50)
    }

    override func tearDown() {
        UserDefaults.clearData()
        super.tearDown()
    }

    func testCompletedLevelNumbersParsesDefaults() {
        verifySimilarArrays(LevelCache.completedLevelNumbers, [10, 2, 1])
    }

    func testCompletedLevelNumbersDiscludesInvalidKeys() {
        verifySimilarArrays(LevelCache.completedLevelNumbers, [10, 2, 1])
        UserDefaults.set(newLevels: fixedLevels.update(with: ["level3 is awesome!!!": 50]))

        verifySimilarArrays(LevelCache.completedLevelNumbers, [10, 2, 1])
    }

    func testHighestLevel() {
        XCTAssertEqual(LevelCache.highestLevel, 10)

        UserDefaults.set(newLevels: fixedLevels.update(with: ["75": 3]))
        XCTAssertEqual(LevelCache.highestLevel, 75)
        UserDefaults.clearData()

        UserDefaults.set(newLevels: fixedLevels)
        XCTAssertEqual(LevelCache.highestLevel, 10)

        UserDefaults.set(newLevels: fixedLevels.update(with: ["9": 2000]))
        XCTAssertEqual(LevelCache.highestLevel, 10)
    }

    func testTotalStarsEarned() {
        XCTAssertEqual(LevelCache.totalStarsEarned, 6)

        UserDefaults.set(newLevels: fixedLevels.update(with: ["75": 50]))
        XCTAssertEqual(LevelCache.totalStarsEarned, 56)

        UserDefaults.set(newLevels: fixedLevels.update(with: ["75": -1]))
        XCTAssertEqual(LevelCache.totalStarsEarned, 5)
    }

    func testCompleteLevelFirstTimeSavesToUserDefaults() {
        LevelCache.completeLevel(levelNumber: 75, starsEarned: 40)

        XCTAssertEqual(UserDefaults.levels, fixedLevels.update(with: ["75": 40]))
        XCTAssertEqual(LevelCache.totalStarsEarned, 46)
    }

    func testCompleteLevelAlreadyCompletedSavesToUserDefaults() {
        LevelCache.completeLevel(levelNumber: 1, starsEarned: 40)

        XCTAssertEqual(UserDefaults.levels, fixedLevels.update(with: ["1": 40]))
        XCTAssertEqual(LevelCache.totalStarsEarned, 43)
    }

    func testAddCoins() {
        LevelCache.add(coins: 10000)
        XCTAssertEqual(UserDefaults.coins, 10050)
    }

    func testRemoveCoinsWithBalanceLeftoverSucceeds() {
        let withdrawalSucceeded = LevelCache.remove(coins: 20)

        XCTAssertEqual(UserDefaults.coins, 30)
        XCTAssertTrue(withdrawalSucceeded)
    }

    func testRemoveCoinsWithNoBalanceRemainingSucceeds() {
        let withdrawalSucceeded = LevelCache.remove(coins: 50)

        XCTAssertEqual(UserDefaults.coins, 0)
        XCTAssertTrue(withdrawalSucceeded)
    }

    func testRemoveCoinsWithNotEnoughBalanceFails() {
        let withdrawalSucceeded = LevelCache.remove(coins: 100)

        XCTAssertEqual(UserDefaults.coins, 50)
        XCTAssertFalse(withdrawalSucceeded)
    }

    func testGetLevelFromNumberSucceedsIfFound() {
        var level: Level?
        var parseError: Error?
        do {
            level = try LevelCache.getLevel(from: 1)
        } catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(level)
    }

    func testGetLevelFromNumberFailsIfNotFound() {
        var level: Level?
        var parseError: Error?
        do {
            level = try LevelCache.getLevel(from: 254784365923)
        } catch let error {
            parseError = error
        }

        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? FileParseError, .notFound)
        XCTAssertNil(level)
    }
}

private extension LevelCacheTests {
    func verifySimilarArrays(_ array1: [Int], _ array2: [Int]) {
        XCTAssertEqual(array1.sorted(), array2.sorted())
    }
}
