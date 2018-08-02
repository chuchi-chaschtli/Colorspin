//
//  Cost.swift
//  Colorspin
//
//  Created by Anand Kumar on 8/2/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

struct Cost {
    let stars: Int
    let coins: Int
}

// MARK: - JSON
extension Cost: JSONParser {
    init(json: JSON?) throws {
        guard let json = json else {
            throw JSONParseError.empty
        }

        guard let stars = json["stars"] as? Int, let coins = json["coins"] as? Int else {
            throw JSONParseError.fail
        }

        self.init(stars: stars, coins: coins)
    }
}

// MARK: - Equatable
extension Cost: Equatable {
    static func == (lhs: Cost, rhs: Cost) -> Bool {
        return lhs.stars == rhs.stars && lhs.coins == rhs.coins
    }
}
