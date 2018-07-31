//
//  ParseError.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

enum JSONParseError: Error {
    case empty
    case fail
    case malformed
}

enum FileParseError: Error {
    case notFound
}
