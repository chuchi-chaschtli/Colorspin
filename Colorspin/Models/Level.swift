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
    var safetyBuffer: Double
    var tps: Int

    init(wheel: Wheel, particles: [Particle], safetyBuffer: Double = 0.2, tps: Int = 1) {
        self.wheel = wheel
        self.particles = particles
        self.safetyBuffer = safetyBuffer.clamp(0, 1)
        self.tps = Int(Double(tps).clamp(1, 60))
    }
}

extension Level {
    var millisecondsPerTick: Double {
        return 1000.0 / Double(tps)
    }
}

extension Level: JSONParser {
    init(json: JSON?, timestamp: Date = Date()) throws {
        guard let json = json else {
            throw JSONParseError.empty
        }

        guard let wheel: Wheel = try? Wheel(json: json["wheel"] as? JSON),
            let particles: [Particle] = try? Particle.array(from: json["particles"] as? [JSON]),
            let safetyBuffer = json["safetyBuffer"] as? Double else {
                throw JSONParseError.fail
        }

        let tps = json["tps"] as? Int ?? 1

        self.init(wheel: wheel, particles: particles, safetyBuffer: safetyBuffer, tps: tps)
    }
}

extension Level: Equatable {
    static func ==(lhs: Level, rhs: Level) -> Bool {
        return lhs.wheel == rhs.wheel && lhs.particles == rhs.particles
    }
}
