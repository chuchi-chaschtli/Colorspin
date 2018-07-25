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
        
        let level1 = Level(wheel: wheel, particles: [particle])
        let level2 = Level(wheel: wheel, particles: [])
        
        XCTAssertFalse(level1 == level2)
        XCTAssertTrue(level1 == level1)
    }
    
    func testLevelSetup() {
        let wheel = Wheel(slices: [(scale: 1, color: .green), (scale: 2, color: .black)], center: CGPoint(x: 40, y: 100), radius: 50)
        let particle1 = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .red, speed: 1.5)
        let particle2 = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .green, speed: 1.5)
        
        let level = Level(wheel: wheel, particles: [particle1, particle2])
        
        XCTAssertEqual(level.particles.count, 2)
        XCTAssertEqual(level.wheel, wheel)
    }
    
    func testLevelFromJson() {
//        let json: JSON = [
//            "x": CGFloat(183),
//            "y": CGFloat(0),
//            "radius": CGFloat(20),
//            "color": "yellow",
//            "speed": CGFloat(1.5),
//            "repeatEvery": 7,
//            "startingTick": 3
//        ]
//        let particle = try? Particle(json: json)
//        
//        XCTAssertNotNil(particle)
//        XCTAssertEqual(particle?.repeatEvery, 7)
//        XCTAssertEqual(particle?.starting, 3)
//        XCTAssertEqual(particle?.speed, 1.5)
//        XCTAssertEqual(particle?.node.position, CGPoint(x: 183, y: 0))
//        XCTAssertEqual(particle?.node.zPosition, 0)
//        XCTAssertEqual(particle?.node.fillColor, .yellow)
//        XCTAssertEqual(particle?.node.strokeColor, .yellow)
    }
}
