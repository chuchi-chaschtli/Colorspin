//
//  LevelCache.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

struct LevelCache {
    static var completedLevelNumbers: [Int] {
        return UserDefaults.levels.keys.compactMap { (levelString) -> Int? in
            return Int(levelString)
        }
    }

    static var highestLevel: Int {
        return completedLevelNumbers.sorted { $0 < $1 }.last ?? 0
    }

    static var totalStarsEarned: Int {
        return UserDefaults.levels.values.reduce(0, +)
    }

    static func completeLevel(levelNumber: Int, starsEarned: Int) {
        let levelString = "\(levelNumber)"
        UserDefaults.set(newLevels: [levelString: starsEarned])

        var levelId = highestLevel + 1
        if Build.isRunningUnitTests {
            levelId = -1
        }
        _ = unlockWithStars(level: highestLevel + 1, cost: (try? getLevel(from: levelId))?.cost.stars)
    }

    static func add(coins: Int) {
        UserDefaults.set(coins: UserDefaults.coins + coins)
    }

    static func remove(coins: Int) -> Bool {
        let diff = UserDefaults.coins - coins
        if diff >= 0 {
            UserDefaults.set(coins: diff)
        }
        return diff >= 0
    }

    private static func unlockWithStars(level: Int, cost: Int?) -> Bool {
        guard let cost = cost else {
            return false
        }

        guard !UserDefaults.unlockedLevels.contains(level) else {
            return true;
        }

        let canUnlock = cost <= totalStarsEarned

        if canUnlock {
            UserDefaults.set(unlockedLevels: UserDefaults.unlockedLevels + [level])
        }
        return canUnlock
    }
}

extension LevelCache {
    static func getLevel(from number: Int) throws -> Level {
        let fileName = "level" + (number > -1 ? "\(number)" : "")

        return try Level(data: FileReader.read(fileName))
    }
}
