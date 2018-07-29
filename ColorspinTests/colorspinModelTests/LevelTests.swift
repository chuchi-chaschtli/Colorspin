//
//  LevelTests.swift
//  colorspinModelTests
//
//  Created by Anand Kumar on 7/22/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class LevelTests: XCTestCase {

    func testLevelEquatable() {
        let wheel = Wheel(slices: [(scale: 1, color: .green), (scale: 2, color: .black)], center: CGPoint(x: 40, y: 100), radius: 50)
        let particle = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .red, speed: 1.5)

        let level1 = Level(wheel: wheel, particles: [particle], stars: fixedStars)
        let level2 = Level(wheel: wheel, particles: [], stars: fixedStars)

        XCTAssertFalse(level1 == level2)
        XCTAssertTrue(level1 == level1)
    }

    func testLevelSetup() {
        let wheel = Wheel(slices: [(scale: 1, color: .green), (scale: 2, color: .black)], center: CGPoint(x: 40, y: 100), radius: 50)
        let particle1 = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .red, speed: 1.5)
        let particle2 = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .green, speed: 1.5)

        let level = Level(wheel: wheel, particles: [particle1, particle2], stars: fixedStars, safetyBuffer: 0.3, tps: 4)

        XCTAssertEqual(level.particles.count, 2)
        XCTAssertEqual(level.wheel, wheel)
        XCTAssertEqual(level.safetyBuffer, 0.3)
        XCTAssertEqual(level.tps, 4)
        XCTAssertEqual(level.millisecondsPerTick, 250.0)

        XCTAssertEqual(level.stars.bronze, Star(scoreToReach: 1, type: .bronze))
    }

    func testLevelFromJson() {
        let level = try? Level(data: levelData)

        XCTAssertNotNil(level)
        XCTAssertEqual(level?.particles.count, 4)
        XCTAssertEqual(level?.safetyBuffer, 0.2)
        XCTAssertEqual(level?.tps, 1)
        XCTAssertEqual(level?.millisecondsPerTick, 1000.0)
        XCTAssertEqual(level?.stars.bronze, Star(scoreToReach: 1, type: .bronze))
    }
}
