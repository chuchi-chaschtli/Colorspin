//
//  ArrayExtension.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/21/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

extension Array {
    /// Splits an array into two arrays based on a filtering predicate.
    ///
    /// - Parameter predicate: The predicate to filter the given array
    /// - Returns: two arrays. The matching array contains elements satisfying this predicate, the notMatching array contains every other element.
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

    /// Mutating for each function
    ///
    /// - Parameter body: Function to mutate the elements in the array.
    /// - Throws: if mutation fails
    mutating func mutateEach(body: (inout Element) throws -> Void) rethrows {
        for index in self.indices {
            try body(&self[index])
        }
    }
}
