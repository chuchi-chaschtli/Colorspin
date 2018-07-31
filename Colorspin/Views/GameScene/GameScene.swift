//
//  GameScene.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/14/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private (set) var level: Level?
    private (set) var spawnedParticles: [Particle] = [Particle]()

    private var score: Int = 0 {
        didSet {
            scoreLabel?.text = "Score: \(score)"
        }
    }
    private (set) var scoreLabel: SKLabelNode?

    private (set) var lastTick: Date?
    private (set) var tick: Int = 0

    private func spawnParticles() {
        var particlesToSpawn = level?.particles.filter({ (particle) -> Bool in
            tick % particle.repeatEvery == particle.starting && tick >= particle.starting
        }) ?? []

        particlesToSpawn.mutateEach { (particle) in
            if let copyNode = particle.node.copy() as? SKShapeNode {
                addChild(copyNode)
                particle.node = copyNode
                spawnedParticles.append(particle)
            }
        }
    }

    private func despawnParticles() {
        guard let level = level else {
            return
        }

        let wheel = level.wheel
        let separatedParticles = spawnedParticles.separate { (particle) -> Bool in
            return wheel.center.y + wheel.radius * CGFloat(1.0 - level.safetyBuffer) <= particle.node.position.y
        }

        separatedParticles.notMatching.forEach { (particle) in
            if particle.node.fillColor == wheel.topSlice?.fillColor {
                score += 1
            }
            particle.node.removeFromParent()
        }
        spawnedParticles = separatedParticles.matching
    }

    func start() {
        lastTick = Date()
    }

    func stop() {
        lastTick = nil
    }

    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        level?.wheel.rotate(for: 0.9, reverse: sender.location(in: view).x >= (view?.frame.width ?? 0) / 2)
    }
}

// MARK: - Lifecycle
extension GameScene {
    override func sceneDidLoad() {
        level = try? Level(data: FileReader.read("level1"))

        anchorPoint = CGPoint(x: 0, y: 1)
        backgroundColor = .lightGray

        scoreLabel = self.childNode(withName: "//scoreLabel") as? SKLabelNode
        scoreLabel?.text = "Score: \(score)"
    }

    override func didMove(to view: SKView) {
        level?.wheel.nodes.forEach({ (node) in
            addChild(node)
        })

        let pressed = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        pressed.delegate = self
        pressed.minimumPressDuration = 0.2
        view.addGestureRecognizer(pressed)

        start()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else {
            return
        }

        level?.wheel.rotate(reverse: firstTouch.location(in: view).x >= (view?.frame.width ?? 0) / 2)
    }

    override func update(_ currentTime: TimeInterval) {
        guard let level = level, let lastTick = lastTick else {
            return
        }

        despawnParticles()
        spawnedParticles.forEach { (particle) in
            particle.node.position.y -= particle.speed
        }

        var timePassed = 1000.0
        if Build.isRunningUnitTests {
            timePassed *= currentTime
        } else {
            timePassed *= -lastTick.timeIntervalSinceNow
        }

        if timePassed > level.millisecondsPerTick {
            self.lastTick = Date()

            spawnParticles()
            tick += 1
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension GameScene: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

#if DEBUG
extension GameScene {
    var started: Bool {
        return lastTick != nil
    }

    func set(level: Level) {
        self.level = level
    }

    func set(lastTick: Date = Date()) {
        self.lastTick = lastTick
    }
}
#endif
