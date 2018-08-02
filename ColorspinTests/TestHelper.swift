//
//  TestHelper.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

extension XCTestCase {
    var fixedRect: CGRect {
        return CGRect(x: 0, y: 0, width: 375, height: 667)
    }

    var fixedDate: Date {
        var dateComponents = DateComponents()
        dateComponents.month = 1
        dateComponents.day = 1
        dateComponents.year = 2018
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.calendar = .current

        return dateComponents.date!
    }

    var fixedStars: Stars {
        let bronze = Star(scoreToReach: 1, type: .bronze)
        let silver = Star(scoreToReach: 2, type: .silver)
        let gold = Star(scoreToReach: 3, type: .gold)
        return (bronze: bronze, silver: silver, gold: gold)
    }

    var fixedCost: Cost {
        return Cost(stars: 5, coins: 7)
    }
}

// MARK: - Fixtures
extension XCTestCase {
    func dataFromFixtureNamed(_ fileName: String) -> Data {
        return try! FileReader.read(fileName, encoding: "json")
    }

    var levelData: Data {
        return dataFromFixtureNamed("level")
    }

    var wheelData: Data {
        return dataFromFixtureNamed("wheel")
    }
}
