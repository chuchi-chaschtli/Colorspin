//
//  JSONProtocol.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/21/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

typealias JSON = [String: Any?]

protocol JSONParser {
    init(json: JSON?, timestamp: Date) throws
}

extension JSONParser {
    static func array<Model: JSONParser>(from data: Data?) throws -> [Model] {
        guard let data = data, !data.isEmpty else {
            throw JSONParseError.malformed
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let data: [Model] = try Self.array(from: json as AnyObject?)

            return data
        } catch {
            throw error
        }
    }

    static func array<Model: JSONParser>(from json: Any?) throws -> [Model] {
        guard json != nil else {
            throw JSONParseError.fail
        }

        if let array = json as? [JSON] {
            return array.compactMap({ (json) -> Model? in
                try? Model(json: json, timestamp: Date())
            })
        }

        guard let json = json as? JSON else {
            throw JSONParseError.fail
        }

        var data = [Model]()
        if json.isEmpty {
            return data
        }

        do {
            data.append(try Model(json: json, timestamp: Date()))
        } catch {
            throw error
        }
        return data
    }

    init(data: Data, timestamp: Date = Date()) throws {
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSON else {
            throw JSONParseError.fail
        }

        try self.init(json: json, timestamp: timestamp)
    }
}
