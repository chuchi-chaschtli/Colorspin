//
//  GameScene.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/14/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var level: Level?
    
    private var spawnedParticles: [Particle] = [Particle]()

    private var score: Int = 0 {
        didSet {
            scoreLabel?.text = "Score: \(score)"
        }
    }
    private var scoreLabel: SKLabelNode?
    private var gameSceneView: UIView?

    private var tickLengthMillis: TimeInterval = TimeInterval(1000)
    private var lastTick: NSDate?
    private var tick: Int = 0

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

        if firstTouch.location(in: view).x >= (view?.frame.width ?? 0) / 2 {
            level?.wheel.rotate(at: -CGFloat(Double.pi) / 2)
        } else {
            level?.wheel.rotate()
        }
    }

    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.location(in: view).x >= (view?.frame.width ?? 0) / 2 {
            level?.wheel.rotate(at: -CGFloat(Double.pi) / 2, for: 0.9)
        } else {
            level?.wheel.rotate(for: 0.9)
        }
    }
    
    func start() {
        lastTick = NSDate()
    }
    
    func stop() {
        lastTick = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let lastTick = lastTick else {
            return
        }
        
        despawnParticles()
        spawnedParticles.forEach { (particle) in
            particle.node.position.y -= particle.speed
        }
        
        let timePassed = lastTick.timeIntervalSinceNow * -1000.0
        if timePassed > tickLengthMillis {
            self.lastTick = NSDate()

            spawnParticles()
            tick += 1
        }
    }
    
    private func spawnParticles() {
        var particlesToSpawn = level?.particles.filter({ (particle) -> Bool in
            tick % particle.repeatEvery == particle.starting && tick >= particle.starting
        }) ?? []

        for index in 0 ..< particlesToSpawn.count {
            if let copyNode = particlesToSpawn[index].node.copy() as? SKShapeNode {
                addChild(copyNode)
                particlesToSpawn[index].node = copyNode
                spawnedParticles.append(particlesToSpawn[index])
            }
        }
    }
    
    private func despawnParticles() {
        guard let wheel = level?.wheel else {
            return
        }

        let separatedParticles = spawnedParticles.separate { (particle) -> Bool in
            return wheel.center.y + wheel.radius * 0.85 <= particle.node.position.y
        }

        separatedParticles.notMatching.forEach { (particle) in
            if particle.node.fillColor == topWheelNode?.fillColor {
                score += 1
            }
            particle.node.removeFromParent()
        }
        spawnedParticles = separatedParticles.matching
    }
    
    private var topWheelNode: SKShapeNode? {
        guard let wheel = level?.wheel else {
            return nil
        }

        return wheel.nodes.first(where: { (node) -> Bool in
            node.contains(CGPoint(x: node.position.x, y: node.position.y + wheel.radius / 2))
        })
    }
}

extension GameScene: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
