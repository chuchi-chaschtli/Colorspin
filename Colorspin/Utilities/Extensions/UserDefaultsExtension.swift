//
//  UserDefaultsExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

private enum UserDefaultKeys: String {
    case coins
    case currentLevel
    case unlockedLevels
    case levels

    static let values: [UserDefaultKeys] = [coins, currentLevel, unlockedLevels, levels]
}

// MARK: - Setup
private extension UserDefaults {
    static var colorspinData: UserDefaults {
        return UserDefaults(suiteName: Bundle().bundleIdentifier) ?? UserDefaults.standard
    }
}

// MARK: - Helpers
extension UserDefaults {
    static func clearData() {
        UserDefaultKeys.values.forEach { (key) in
            colorspinData.removeObject(forKey: key.rawValue)
        }
        colorspinData.synchronize()
    }

    static var coins: Int {
        return colorspinData.integer(forKey: UserDefaultKeys.coins.rawValue)
    }

    static var currentlevel: Int {
        return colorspinData.integer(forKey: UserDefaultKeys.currentLevel.rawValue)
    }

    static var unlockedLevels: [Int] {
        return colorspinData.array(forKey: UserDefaultKeys.unlockedLevels.rawValue) as? [Int] ?? [1]
    }

    static var levels: [String: Int] {
        return (colorspinData.dictionary(forKey: UserDefaultKeys.levels.rawValue) as? [String: Int]) ?? [:]
    }

    static func set(coins: Int) {
        colorspinData.set(coins, forKey: UserDefaultKeys.coins.rawValue)
    }

    static func set(currentLevel: Int) {
        colorspinData.set(currentLevel, forKey: UserDefaultKeys.currentLevel.rawValue)
    }

    static func set(unlockedLevels: [Int]) {
        colorspinData.set(unlockedLevels, forKey: UserDefaultKeys.unlockedLevels.rawValue)
    }

    static func set(newLevels: [String: Int]) {
        colorspinData.setValue(levels.update(with: newLevels), forKeyPath: UserDefaultKeys.levels.rawValue)
    }
}
