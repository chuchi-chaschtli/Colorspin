//
//  ArrayExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/21/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

extension Array {
    func separate(using predicate: (Element) -> Bool) -> (matching: [Element], notMatching: [Element]) {
        var groups: ([Element], [Element]) = ([], [])
        self.forEach { (element) in
            if predicate(element) {
                groups.0.append(element)
            } else {
                groups.1.append(element)
            }
        }
        return groups
    }

    mutating func mutateEach(body: (inout Element) throws -> Void) rethrows {
        for index in self.indices {
            try body(&self[index])
        }
    }
}
