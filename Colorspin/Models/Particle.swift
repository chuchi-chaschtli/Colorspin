//
//  Particle.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/15/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import SpriteKit

struct Particle {
    var node: SKShapeNode
    let speed: CGFloat

    let repeatEvery: Int
    let starting: Int

    init(at center: CGPoint, radius: CGFloat, color: UIColor, speed: CGFloat, repeatEvery: Int = 1, starting: Int = 0) {
        self.speed = speed
        self.repeatEvery = repeatEvery
        self.starting = starting

        let path = CGMutablePath()

        path.addRect(CGRect(x: center.x, y: center.y, width: radius, height: radius))

        node = SKShapeNode(path: path)
        node.fillColor = color
        node.strokeColor = color
        node.glowWidth = 0.5
        node.position = center
        node.zPosition = 0
    }
}

// MARK: - JSON
extension Particle: JSONParser {
    init(json: JSON?) throws {
        guard let json = json else {
            throw JSONParseError.empty
        }

        guard let x = json["x"] as? CGFloat,
            let y = json["y"] as? CGFloat,
            let radius = json["radius"] as? CGFloat,
            let speed = json["speed"] as? CGFloat,
            let colorString = json["color"] as? String,
            let color = UIColor(name: colorString) else {
                throw JSONParseError.fail
        }

        let repeatEvery = json["repeatEvery"] as? Int ?? 1
        let starting = json["startingTick"] as? Int ?? 0

        self.init(at: CGPoint(x: x, y: y), radius: radius, color: color, speed: speed, repeatEvery: repeatEvery, starting: starting)
    }
}

// MARK: - Equatable
extension Particle: Equatable {
    static func == (lhs: Particle, rhs: Particle) -> Bool {
        return lhs.node == rhs.node && lhs.speed == rhs.speed
    }
}
