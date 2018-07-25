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

    init(slices: [(scale: CGFloat, color: UIColor)], center: CGPoint, radius: CGFloat) {
        let totalScale = slices.reduce(0, {$0 + $1.scale})
        var angle = CGFloat(Double.pi) * 3 / 4

        self.radius = radius
        self.center = center

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

    func rotate(at angle: CGFloat = CGFloat(Double.pi) / 2, for duration: Double = 0.5) {
        nodes.forEach({(slice) in
            slice.run(SKAction.rotate(byAngle: angle, duration: duration))
        })
    }
}

extension Wheel: JSONParser {
    init(json: JSON?, timestamp: Date = Date()) throws {
        guard let json = json else {
            throw ParseError.empty
        }

        guard let x = json["centerX"] as? CGFloat,
            let y = json["centerY"] as? CGFloat,
            let radius = json["radius"] as? CGFloat,
            let slicesObject = json["slices"] as? String else {
                throw ParseError.fail
        }

        let slices = try slicesObject.split(separator: ",").compactMap({slice -> (CGFloat, UIColor)? in
            let sliceParts = slice.split(separator: ":")
            guard let color = UIColor.stringsToColors[String(sliceParts[0])], let value = Float(String(sliceParts[1])) else {
                throw ParseError.malformed
            }
            return (CGFloat(value), color)
        })

        self.init(slices: slices, center: CGPoint(x: x, y: y), radius: radius)
    }
}

extension Wheel: Equatable {
    static func ==(lhs: Wheel, rhs: Wheel) -> Bool {
        return lhs.nodes == rhs.nodes
    }
}
