//
//  DictionaryExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/30/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

extension Dictionary {
    /// Updates the dictionary with the given one by overwriting existing keys with new values provided and adding key value pairs that weren't
    /// already a part of the dictionary.
    ///
    /// - Parameter that: Dictionary of the same type as this one
    /// - Returns: the updated dictionary
    func update(with that: Dictionary) -> Dictionary {
        var dict = self
        for (key, value) in that {
            dict.updateValue(value, forKey: key)
        }
        return dict
    }
}
