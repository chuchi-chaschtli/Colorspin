//
//  Star.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/29/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation
import UIKit

enum StarType: String {
    case bronze
    case silver
    case gold

    var color: UIColor {
        return UIColor(name: self.rawValue) ?? .black
    }
}

struct Star {
    var scoreToReach: Int
    var type: StarType
}

extension Star: JSONParser {
    init(json: JSON?, timestamp: Date = Date()) throws {
        guard let json = json else {
            throw JSONParseError.empty
        }

        guard let scoreToReach = json["scoreThreshold"] as? Int,
            let typeValue = json["type"] as? String,
            let type = StarType(rawValue: typeValue) else {
                throw JSONParseError.fail
        }

        self.init(scoreToReach: scoreToReach, type: type)
    }
}

extension Star: Equatable {
    static func == (lhs: Star, rhs: Star) -> Bool {
        return lhs.scoreToReach == rhs.scoreToReach && lhs.type == rhs.type
    }
}
