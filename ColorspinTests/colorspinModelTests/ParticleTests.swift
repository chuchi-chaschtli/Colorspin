//
//  ParticleTests.swift
//  colorspinModelTests
//
//  Created by Anand Kumar on 7/22/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class ParticleTests: XCTestCase {

    func testParticleEquatable() {
        let particle1 = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .red, speed: 1.5)
        let particle2 = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .green, speed: 1.5)
        
        XCTAssertFalse(particle1 == particle2)
        XCTAssertTrue(particle1 == particle1)
    }
    
    func testParticleSetup() {
        let particle = Particle(at: CGPoint(x: 40, y: 100), radius: 20, color: .red, speed: 1.5)
        
        XCTAssertEqual(particle.repeatEvery, 1)
        XCTAssertEqual(particle.starting, 0)
        XCTAssertEqual(particle.speed, 1.5)

        XCTAssertEqual(particle.node.position, CGPoint(x: 40, y: 100))
        XCTAssertEqual(particle.node.zPosition, 0)
        XCTAssertEqual(particle.node.fillColor, .red)
        XCTAssertEqual(particle.node.strokeColor, .red)
    }
    
    func testParticleFromJson() {
        let json: JSON = [
            "x": CGFloat(183),
            "y": CGFloat(0),
            "radius": CGFloat(20),
            "color": "yellow",
            "speed": CGFloat(1.5),
            "repeatEvery": 7,
            "startingTick": 3
        ]
        let particle = try? Particle(json: json)
        
        XCTAssertNotNil(particle)
        XCTAssertEqual(particle?.repeatEvery, 7)
        XCTAssertEqual(particle?.starting, 3)
        XCTAssertEqual(particle?.speed, 1.5)
        XCTAssertEqual(particle?.node.position, CGPoint(x: 183, y: 0))
        XCTAssertEqual(particle?.node.zPosition, 0)
        XCTAssertEqual(particle?.node.fillColor, .yellow)
        XCTAssertEqual(particle?.node.strokeColor, .yellow)
    }
    
    func testBadJson() {
        let json: JSON = [
            "x": true,
            "y": CGFloat(0),
            "radius": "hehe",
            "color": "yellow",
            "speed": CGFloat(1.5),
            "repeatEvery": 4.0,
            "startingTick": 3
        ]
        let particle = try? Particle(json: json)
        
        XCTAssertNil(particle)
    }
}
