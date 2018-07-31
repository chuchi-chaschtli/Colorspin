//
//  DoubleExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

extension Double {
    /// Forces this value to be in between two bounds, either inclusive (default) or exclusive.
    ///
    /// - Parameters:
    ///   - x: the first bound
    ///   - y: the second bound.
    ///   - inclusive: flag whether or not specifying to be inclusive in clamping (default = true)
    /// - Returns: the clamped value.
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
