//
//  WheelTests.swift
//  colorspinModelTests
//
//  Created by Anand Kumar on 7/15/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class WheelTests: XCTestCase {

    func testWheelEquatable() {
        let wheel1 = Wheel(slices: [(scale: 1, color: .green)], center: CGPoint(x: 40, y: 100), radius: 50)
        let wheel2 = Wheel(slices: [(scale: 1, color: .green), (scale: 2, color: .black)], center: CGPoint(x: 40, y: 100), radius: 50)

        XCTAssertFalse(wheel1 == wheel2)
        XCTAssertTrue(wheel1 == wheel1)
    }
    
    func testWheelNodesSetup() {
        let wheel = Wheel(slices: [(scale: 1, color: .green), (scale: 2, color: .black)], center: CGPoint(x: 40, y: 100), radius: 50)

        XCTAssertEqual(wheel.nodes.count, 2)
        XCTAssertEqual(wheel.nodes[0].fillColor, .green)

        wheel.nodes.forEach { (node) in
            XCTAssertEqual(node.position, CGPoint(x: 40, y: 100))
            XCTAssertEqual(node.glowWidth, 0.5)
            XCTAssertEqual(node.zPosition, 1)
        }
    }
    
    func testWheelFromJson() {
        let json: JSON = [
            "slices": "green:1,red:1,yellow:1,blue:1",
            "centerX": CGFloat(375),
            "centerY": CGFloat(-1200),
            "radius": CGFloat(100)
        ]
        let wheel = try? Wheel(json: json)
        
        XCTAssertNotNil(wheel)
        XCTAssertEqual(wheel?.nodes.count, 4)
        XCTAssertEqual(wheel?.radius, 100)
        XCTAssertEqual(wheel?.nodes[0].position, CGPoint(x: 375, y: -1200))
    }
    
    func testBadJson() {
        let json: JSON = [
            "slices": false,
            "centerX": CGFloat(375),
            "centerY": CGFloat(-1200),
            "radius": CGFloat(100)
        ]
        let wheel = try? Wheel(json: json)
        
        XCTAssertNil(wheel)
    }
    
    func testWheelRotateMaintainsState() {
        let wheel = Wheel(slices: [(scale: 1, color: .green), (scale: 2, color: .black)], center: CGPoint(x: 40, y: 100), radius: 50)
        
        wheel.rotate()
        wheel.nodes.forEach { (node) in
            XCTAssertEqual(node.position, CGPoint(x: 40, y: 100))
            XCTAssertEqual(node.glowWidth, 0.5)
            XCTAssertEqual(node.zPosition, 1)
        }
    }
}
