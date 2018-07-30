//
//  DictionaryExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

extension Dictionary {
    func update(with that: Dictionary) -> Dictionary {
        var dict = self
        for (key, value) in that {
            dict.updateValue(value, forKey: key)
        }
        return dict
    }
}
