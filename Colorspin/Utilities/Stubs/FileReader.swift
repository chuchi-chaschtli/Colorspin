//
//  FileReader.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/22/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

struct FileReader {
    static func read(_ name: String, encoding: String = "json") throws -> Data {
        guard let path = Bundle.main.path(forResource: name, ofType: encoding) else {
            throw FileParseError.notFound
        }

        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            throw error
        }
    }
}
