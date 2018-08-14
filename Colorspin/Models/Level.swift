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
    let wheel: Wheel
    let particles: [Particle]
    let stars: Stars
    let cost: Cost
    let safetyBuffer: Double
    let tps: Int
    let finalTick: Int

    init(wheel: Wheel, particles: [Particle], stars: Stars, cost: Cost, safetyBuffer: Double = 0.2, tps: Int = 1, finalTick: Int) {
        self.wheel = wheel
        self.particles = particles
        self.stars = stars
        self.cost = cost
        self.safetyBuffer = safetyBuffer.clamp(0, 1)
        self.tps = Int(Double(tps).clamp(1, 60))
        self.finalTick = finalTick
    }
}

// MARK: - Helpers
extension Level {
    var millisecondsPerTick: Double {
        return 1000.0 / Double(tps)
    }

    private func timeRemaining(at tick: Int) -> Double {
        let totalSeconds = Double(finalTick) / Double(tps)
        let currentSeconds = Double(tick) / Double(tps)

        return totalSeconds - currentSeconds
    }

    func timeLeft(at tick: Int) -> String {
        let timeLeft = timeRemaining(at: tick)
        let minutes = Int(timeLeft) / 60
        let seconds = Int(timeLeft) % 60

        let formattedMinutes = (minutes < 10 ? "0" : "") + "\(minutes)"
        let formattedSeconds = (seconds < 10 ? "0" : "") + "\(seconds)"
        return "\(formattedMinutes):\(formattedSeconds)"
    }

    func isTimeRunningOut(at tick: Int) -> Bool {
        return timeRemaining(at: tick) <= 10
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
            let cost: Cost = try? Cost(json: json["cost"] as? JSON),
            let safetyBuffer = json["safetyBuffer"] as? Double,
            let finalTick = json["finalTick"] as? Int else {
                throw JSONParseError.fail
        }

        let formattedStars: Stars = (bronze: stars[0], silver: stars[1], gold: stars[2])

        let tps = json["tps"] as? Int ?? 1

        self.init(wheel: wheel, particles: particles, stars: formattedStars, cost: cost, safetyBuffer: safetyBuffer, tps: tps, finalTick: finalTick)
    }
}

// MARK: - Equatable
extension Level: Equatable {
    static func == (lhs: Level, rhs: Level) -> Bool {
        return lhs.wheel == rhs.wheel
            && lhs.particles == rhs.particles
            && lhs.stars == rhs.stars
            && lhs.cost == rhs.cost
            && lhs.safetyBuffer == rhs.safetyBuffer
            && lhs.tps == rhs.tps
            && lhs.finalTick == rhs.finalTick
    }
}
