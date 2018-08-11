//
//  GameSceneViewControllerTests.swift
//  colorspinViewsTests
//
//  Created by Anand Kumar on 8/2/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Colorspin

class GameSceneViewControllerTests: XCTestCase {
    var sut: GameSceneViewController!

    override func setUp() {
        super.setUp()

        sut = GameSceneViewController()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func testViewDidLoadSetsMinimumCurrentLevel() {
        UserDefaults.clearData()

        sut.viewDidLoad()
        XCTAssertEqual(UserDefaults.currentlevel, 1)
    }

    func testViewPropertiesAreSet() {
        XCTAssertFalse(sut.shouldAutorotate)
        XCTAssertTrue(sut.prefersStatusBarHidden)
        XCTAssertEqual(sut.preferredInterfaceOrientationForPresentation, .portrait)
        XCTAssertEqual(sut.supportedInterfaceOrientations, .portrait)
    }
}
