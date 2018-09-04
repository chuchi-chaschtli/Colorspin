//
//  ImageExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 9/3/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    static var menuScene: UIImage {
        return #imageLiteral(resourceName: "Menu_background")
    }

    static var playButton: UIImage {
        return #imageLiteral(resourceName: "PlayButton")
    }

    static var starOutline: UIImage {
        return #imageLiteral(resourceName: "StarOutline")
    }

    static func star(for type: StarType) -> UIImage {
        switch type {
            case .bronze:
                return #imageLiteral(resourceName: "BRONZEStar")
            case .silver:
                return #imageLiteral(resourceName: "SilverStar")
            case .gold:
                return #imageLiteral(resourceName: "GoldStar")
        }
    }

    static func stars(for earned: Int) -> [UIImage] {
        var result = [starOutline, starOutline, starOutline]

        if earned >= 1 {
            result[0] = star(for: .bronze)
        }
        if earned >= 2 {
            result[1] = star(for: .silver)
        }
        if earned >= 3 {
            result[2] = star(for: .gold)
        }

        return result
    }

    static var title: UIImage {
        return #imageLiteral(resourceName: "ColorSpinTitleV1")
    }
}
