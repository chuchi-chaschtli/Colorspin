//
//  MainMenuViewControllerTests.swift
//  colorspinViewsTests
//
//  Created by Anand Kumar on 8/10/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class MainMenuViewControllerTests: XCTestCase {
    var sut: MainMenuViewController!

    override func setUp() {
        super.setUp()

        sut = MainMenuViewController()
        _ = sut.view
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func testViewDidLoad() {
        XCTAssertEqual(sut.view.backgroundColor, .lightGray)
        XCTAssertEqual(sut.playButton.allTargets.count, 1)
    }

    func testTapPlayButton() {
        let navController = MockNavigationController()
        navController.viewControllers = [sut]

        XCTAssertNil(navController.pushedViewController)
        sut.playButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(navController.pushedViewController is GameSceneViewController)
    }
}

private extension MainMenuViewControllerTests {
    class MockNavigationController: UINavigationController {

        var pushedViewController: UIViewController?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: true)
        }
    }
}
