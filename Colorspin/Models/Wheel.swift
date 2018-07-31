//
//  Wheel.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/15/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import SpriteKit

struct Wheel {
    var nodes: [SKShapeNode] = [SKShapeNode]()

    let radius: CGFloat
    let center: CGPoint
    let totalScale: CGFloat

    init(slices: [(scale: CGFloat, color: UIColor)], center: CGPoint, radius: CGFloat) {
        var angle = CGFloat(Double.pi) * 3 / 4

        self.radius = radius
        self.center = center
        self.totalScale = slices.reduce(0, {$0 + $1.scale})

        self.nodes = slices.map({ (scale, color) -> SKShapeNode in
            let path = UIBezierPath()

            let sliceAngle = CGFloat(Double.pi) * 2 * scale / totalScale

            path.move(to: CGPoint.zero)
            path.addArc(withCenter: CGPoint.zero, radius: radius, startAngle: angle, endAngle: angle - sliceAngle, clockwise: false)
            path.move(to: CGPoint.zero)
            path.close()

            let node = SKShapeNode(path: path.cgPath)
            node.fillColor = color
            node.strokeColor = .black
            node.glowWidth = 0.5
            node.position = center
            node.zPosition = 1

            angle -= sliceAngle
            return node
        })
    }
}

extension Wheel {
    var topSlice: SKShapeNode? {
        return nodes.first(where: { (node) -> Bool in
            node.contains(CGPoint(x: node.position.x, y: node.position.y + radius / 2))
        })
    }

    func rotate(for duration: Double = 0.5, reverse: Bool = false) {
        let rotationFactor = totalScale / (reverse ? -2 : 2)
        let action = SKAction.rotate(byAngle: CGFloat.pi / rotationFactor, duration: duration)

        nodes.forEach({(slice) in
            if Build.isRunningUnitTests {
                slice.run(action, withKey: "rotation")
            } else {
                slice.run(action)
            }
        })
    }
}

extension Wheel: JSONParser {
    init(json: JSON?, timestamp: Date = Date()) throws {
        guard let json = json else {
            throw JSONParseError.empty
        }

        guard let x = json["centerX"] as? CGFloat,
            let y = json["centerY"] as? CGFloat,
            let radius = json["radius"] as? CGFloat,
            let slicesObject = json["slices"] as? String else {
                throw JSONParseError.fail
        }

        let slices = try slicesObject.split(separator: ",").compactMap({slice -> (CGFloat, UIColor)? in
            let sliceParts = slice.split(separator: ":")
            guard let color = UIColor(name: String(sliceParts[0])), let value = Float(String(sliceParts[1])) else {
                throw JSONParseError.malformed
            }
            return (CGFloat(value), color)
        })

        self.init(slices: slices, center: CGPoint(x: x, y: y), radius: radius)
    }
}

extension Wheel: Equatable {
    static func == (lhs: Wheel, rhs: Wheel) -> Bool {
        return lhs.nodes == rhs.nodes
    }
}
