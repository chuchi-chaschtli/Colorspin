//
//  CollectionExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/21/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

extension Collection {
    func separate(using predicate: (Iterator.Element) -> Bool) -> (matching: [Iterator.Element], notMatching: [Iterator.Element]) {
        var groups: ([Iterator.Element],[Iterator.Element]) = ([],[])
        self.forEach { (element) in
            if predicate(element) {
                groups.0.append(element)
            } else {
                groups.1.append(element)
            }
        }
        return groups
    }
}
