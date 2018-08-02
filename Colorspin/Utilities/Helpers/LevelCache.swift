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
}

extension LevelCache {
    static func getLevel(from number: Int) throws -> Level {
        let fileName = "level\(number)"

        return try Level(data: FileReader.read(fileName))
    }
}
