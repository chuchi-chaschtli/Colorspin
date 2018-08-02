//
//  GameSceneTests.swift
//  colorspinViewsTests
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Colorspin

class GameSceneTests: XCTestCase {
    var sut: GameScene!

    override func setUp() {
        super.setUp()

        sut = SKScene(fileNamed: "GameScene") as! GameScene
        sut.set(level: try! Level(data: levelData))
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func testSceneSetup() {
        XCTAssertEqual(sut.anchorPoint, CGPoint(x: 0, y: 1))
        XCTAssertNotNil(sut.level)
        XCTAssertNotNil(sut.scoreLabel)
        XCTAssertEqual(sut.scoreLabel?.text, "Score: 0")
        XCTAssertNotNil(sut.levelLabel)
        XCTAssertEqual(sut.levelLabel?.text, "Level: 1")
    }

    func testSceneInitCallsDidLoad() {
        let spyScene = SpyGameScene()
        XCTAssertTrue(spyScene.sceneDidLoadWasCalled)
    }

    func testDidMoveToViewInitializesLastTick() {
        XCTAssertFalse(sut.started)
        sut.didMove(to: SKView(frame: fixedRect))

        XCTAssertTrue(sut.started)
    }

    func testDidMoveToViewAddsGestureRecognizer() {
        let spyView = SKView(frame: fixedRect)
        sut.didMove(to: spyView)

        XCTAssertNotNil(spyView.gestureRecognizers)
        XCTAssertEqual(spyView.gestureRecognizers?.count, 1)
    }

    func testStartUpdatesLastTick() {
        sut.start()
        XCTAssertNotEqual(sut.lastTick, fixedDate)
    }

    func testStopUpdatesLastTick() {
        sut.stop()
        XCTAssertNil(sut.lastTick)
    }

    func testUpdateDidNothingIfNotTicking() {
        let spyScene = SpyGameScene()
        spyScene.didMove(to: SKView(frame: fixedRect))
        spyScene.stop()

        spyScene.update(0)
        XCTAssertTrue(spyScene.updateDidNothing)
    }

    func testUpdateCallsDespawnParticlesIfTicking() {
        let spyScene = SpyGameScene()
        spyScene.didMove(to: SKView(frame: fixedRect))

        XCTAssertFalse(spyScene.despawnParticlesWasCalled)
        spyScene.update(0)
        XCTAssertTrue(spyScene.despawnParticlesWasCalled)
        XCTAssertFalse(spyScene.updateDidNothing)
    }

    func testUpdateWithEnoughTimeTriggersParticleSpawn() {
        sut.didMove(to: SKView(frame: fixedRect))
        sut.set(lastTick: fixedDate)

        sut.update(2)
        XCTAssertNotEqual(fixedDate, sut.lastTick)
        XCTAssertEqual(sut.spawnedParticles.count, 2)

        let startingY = sut.spawnedParticles[0].node.position.y

        sut.update(0)
        XCTAssertEqual(sut.spawnedParticles[0].node.position.y + 1.5, startingY)
    }

    func testUpdateWithNotEnoughTimeDoesNotTriggerParticleSpawn() {
        sut.didMove(to: SKView(frame: fixedRect))
        sut.set(lastTick: fixedDate)

        sut.update(0.5)
        XCTAssertEqual(fixedDate, sut.lastTick)
        XCTAssertEqual(sut.spawnedParticles.count, 0)
    }

    func testMultipleUpdatesSpawnsMoreParticlesAndTriggersScoreUpdates() {
        sut.didMove(to: SKView(frame: fixedRect))
        sut.set(lastTick: fixedDate)

        sut.update(2)
        XCTAssertEqual(sut.spawnedParticles.count, 2)
        XCTAssertEqual(sut.scoreLabel?.text, "Score: 0")

        for _ in 0...1000 {
            sut.update(2)
        }

        XCTAssertEqual(sut.spawnedParticles.count, 257)
        XCTAssertEqual(sut.scoreLabel?.text, "Score: 9")
    }
}

private extension GameSceneTests {
    class SpyGameScene: GameScene {
        var sceneDidLoadWasCalled = false
        override func sceneDidLoad() {
            sceneDidLoadWasCalled = true
        }

        var despawnParticlesWasCalled = false
        var updateDidNothing = true
        override func update(_ currentTime: TimeInterval) {
            guard started else {
                return
            }

            updateDidNothing = false
            despawnParticlesWasCalled = true
        }
    }
}
