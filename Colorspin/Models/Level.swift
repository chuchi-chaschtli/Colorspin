//
//  Level.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/22/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

struct Level {
    var wheel: Wheel
    var particles: [Particle]
}

extension Level: JSONParser {
    init(json: JSON?, timestamp: Date = Date()) throws {
        guard let json = json else {
            throw ParseError.empty
        }

        guard let wheel: Wheel = try? Wheel(json: json["wheel"] as? JSON),
            let particles: [Particle] = try? Particle.array(from: json["particles"] as? [JSON]) else {
                throw ParseError.fail
        }
        self.init(wheel: wheel, particles: particles)
    }
}

extension Level: Equatable {
    static func ==(lhs: Level, rhs: Level) -> Bool {
        return lhs.wheel == rhs.wheel && lhs.particles == rhs.particles
    }
}
