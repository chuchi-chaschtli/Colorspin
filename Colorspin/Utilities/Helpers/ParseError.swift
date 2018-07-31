//
//  ParseError.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

/// Errors to handle JSON Parsing failures
///
/// - empty: thrown when encountering empty data file
/// - fail: thrown when parsing failed
/// - malformed: thrown when json object is malformed
enum JSONParseError: Error {
    case empty
    case fail
    case malformed
}

/// Errors to handle File reading failures
///
/// - notFound: thrown when the file matching a specified name was not found.
enum FileParseError: Error {
    case notFound
}
