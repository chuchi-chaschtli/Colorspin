//
//  Level.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/22/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

typealias Stars = (bronze: Star, silver: Star, gold: Star)

struct Level {
    var wheel: Wheel
    var particles: [Particle]
    var stars: Stars
    var safetyBuffer: Double
    var tps: Int

    init(wheel: Wheel, particles: [Particle], stars: Stars, safetyBuffer: Double = 0.2, tps: Int = 1) {
        self.wheel = wheel
        self.particles = particles
        self.stars = stars
        self.safetyBuffer = safetyBuffer.clamp(0, 1)
        self.tps = Int(Double(tps).clamp(1, 60))
    }
}

// MARK: - Helpers
extension Level {
    var millisecondsPerTick: Double {
        return 1000.0 / Double(tps)
    }
}

// MARK: - JSON
extension Level: JSONParser {
    init(json: JSON?) throws {
        guard let json = json else {
            throw JSONParseError.empty
        }

        guard let wheel: Wheel = try? Wheel(json: json["wheel"] as? JSON),
            let particles: [Particle] = try? Particle.array(from: json["particles"] as? [JSON]),
            let stars: [Star] = try? Star.array(from: json["stars"] as? [JSON]),
            let safetyBuffer = json["safetyBuffer"] as? Double else {
                throw JSONParseError.fail
        }

        let formattedStars: Stars = (bronze: stars[0], silver: stars[1], gold: stars[2])

        let tps = json["tps"] as? Int ?? 1

        self.init(wheel: wheel, particles: particles, stars: formattedStars, safetyBuffer: safetyBuffer, tps: tps)
    }
}

// MARK: - Equatable
extension Level: Equatable {
    static func == (lhs: Level, rhs: Level) -> Bool {
        return lhs.wheel == rhs.wheel
            && lhs.particles == rhs.particles
            && lhs.stars == rhs.stars
            && lhs.safetyBuffer == rhs.safetyBuffer
            && lhs.tps == rhs.tps
    }
}
