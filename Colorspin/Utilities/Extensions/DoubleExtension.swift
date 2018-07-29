//
//  DoubleExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

extension Double {
    func clamp(_ x: Double, _ y: Double, inclusive: Bool = true) -> Double {
        let minimum = min(x, y)
        let maximum = max(x, y)

        switch self {
            case let z where inclusive ? z < minimum : z <= minimum:
                return minimum
            case let z where inclusive ? z > maximum : z >= maximum:
                return maximum
            default:
                return self
        }
    }
}
