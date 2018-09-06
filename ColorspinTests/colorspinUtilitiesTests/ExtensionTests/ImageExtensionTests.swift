//
//  ImageExtensionTests.swift
//  colorspinUtilitiesTests
//
//  Created by Anand Kumar on 9/3/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class ImageExtensionTests: XCTestCase {
    func testStarImageForStarType() {
        XCTAssertEqual(UIImage.star(for: .bronze), #imageLiteral(resourceName: "BRONZEStar"))
        XCTAssertEqual(UIImage.star(for: .silver), #imageLiteral(resourceName: "SilverStar"))
        XCTAssertEqual(UIImage.star(for: .gold), #imageLiteral(resourceName: "GoldStar"))
    }

    func testStarsForLevelStarsEarned() {
        XCTAssertEqual(UIImage.stars(for: 0), [.starOutline, .starOutline, .starOutline])
        XCTAssertEqual(UIImage.stars(for: 1), [#imageLiteral(resourceName: "BRONZEStar"), .starOutline, .starOutline])
        XCTAssertEqual(UIImage.stars(for: 2), [#imageLiteral(resourceName: "BRONZEStar"), #imageLiteral(resourceName: "SilverStar"), .starOutline])
        XCTAssertEqual(UIImage.stars(for: 3), [#imageLiteral(resourceName: "BRONZEStar"), #imageLiteral(resourceName: "SilverStar"), #imageLiteral(resourceName: "GoldStar")])
        XCTAssertEqual(UIImage.stars(for: 10), [#imageLiteral(resourceName: "BRONZEStar"), #imageLiteral(resourceName: "SilverStar"), #imageLiteral(resourceName: "GoldStar")])
    }
}
