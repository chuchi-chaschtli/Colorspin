//
//  JSONProtocolTests.swift
//  colorspinModelTests
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import XCTest
@testable import Colorspin

class JSONProtocolTests: XCTestCase {

    func testArrayFromNilDataIsMalformed() {
        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: nil)
        } catch let error {
            parseError = error
        }

        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .malformed)
    }

    func testArrayFromEmptyDataIsMalformed() {
        var parseError: Error?
        var resultModel: [MockJSONModel]?

        do {
            resultModel = try MockJSONModel.array(from: Data())
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .malformed)
    }

    func testArrayFromBadJsonDataFails()
    {
        let badJSON = ["horrible json!!!!"]

        var resultModel: [MockJSONModel]?
        var parseError: Error?
        do
        {
            resultModel = try MockJSONModel.array(from: badJSON)
        }
        catch let error
        {
            parseError = error
        }

        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .fail)
    }

    func testArrayFromValidDataSucceeds() {
        let mockModelData = try! JSONSerialization.data(withJSONObject: ["test": "this is the field"], options: .prettyPrinted)

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelData)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(resultModel)
        XCTAssertFalse(resultModel?.isEmpty ?? true)
    }

    func testArrayFromEmptyArrayDataIsEmpty() {
        let mockModelData = try! JSONSerialization.data(withJSONObject: [], options: .prettyPrinted)

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelData)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(resultModel)
        XCTAssertTrue(resultModel?.isEmpty ?? false)
    }

    func testArrayFromEmptyDictionaryDataIsEmpty() {
        let mockModelData = try! JSONSerialization.data(withJSONObject: [:], options: .prettyPrinted)

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelData)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(resultModel)
        XCTAssertTrue(resultModel?.isEmpty ?? false)
    }

    func testArrayFromNonNilDataFails() {
        let mockModelData = try! JSONSerialization.data(withJSONObject: ["test": 2], options: .prettyPrinted)

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelData)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .fail)
    }

    func testArrayFromNilAnyFails() {
        let any: Any? = nil

        var resultModel: [MockJSONModel]?
        var parseError: Error?
        do {
            resultModel = try MockJSONModel.array(from: any)
        }
        catch let error {
            parseError = error
        }
        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .fail)
    }

    func testArrayFromAnyValidSucceeds() {
        let mockModelJSON = [["test": "this is the field"],
                             ["test": "this is the second field"]]

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelJSON)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(resultModel)
        XCTAssertEqual(resultModel?.count, 2)
        XCTAssertFalse(resultModel?.isEmpty ?? true)
    }

    func testArrayFromAnyInvalidJSONDiscardsDuplicateKeys() {
        let mockModelJSON = [["test": "this is the field"],
                             ["test": 2]]

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelJSON)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNotNil(resultModel)
        XCTAssertEqual(resultModel?.count, 1)
        XCTAssertEqual(resultModel?.first?.mockField, "this is the field")
        XCTAssertNil(parseError)
    }

    func testArrayFromAnyInvalidJSONNonArrayFails() {
        let mockModelJSON = ["test": 2]

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelJSON)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .fail)
    }

    func testArrayFromAnyNotJSONNonArrayFails() {
        let mockModelNonJSON = 2

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelNonJSON)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .fail)
    }

    func testArrayFromJSONDictionary() {
        let mockModelJSON = ["test": "this is the field"]

        var resultModel: [MockJSONModel]?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel.array(from: mockModelJSON)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(resultModel)
        XCTAssertEqual(resultModel?.count, 1)
        XCTAssertFalse(resultModel?.isEmpty ?? true)
    }

    func testArrayFromEmptyDictionaryIsEmpty() {
        let mockModelJSON = [AnyHashable: Any]()

        var resultModel: [MockJSONModel]?
        var parseError: Error?
        do {
            resultModel = try MockJSONModel.array(from: mockModelJSON)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNotNil(resultModel)
        XCTAssertTrue(resultModel?.isEmpty ?? false)
        XCTAssertNil(parseError)
    }

    func testArrayFromEmptyObjectIsEmpty() {
        let mockModelJSON = [Any]()

        var resultModel: [MockJSONModel]?
        var parseError: Error?
        do {
            resultModel = try MockJSONModel.array(from: mockModelJSON)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNotNil(resultModel)
        XCTAssertTrue(resultModel?.isEmpty ?? false)
        XCTAssertNil(parseError)
    }

    func testDataInitializationSucceeds() {
        let mockModelData = try! JSONSerialization.data(withJSONObject: ["test": "this is the field"], options: .prettyPrinted)

        var resultModel: MockJSONModel?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel(data: mockModelData)
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(parseError)
        XCTAssertNotNil(resultModel)
    }

    func testDataInitializationFails() {
        var resultModel: MockJSONModel?
        var parseError: Error?

        do {
            resultModel = try MockJSONModel(data: Data())
        }
        catch let error {
            parseError = error
        }

        XCTAssertNil(resultModel)
        XCTAssertNotNil(parseError)
        XCTAssertEqual(parseError as? JSONParseError, .fail)
    }
}

private extension JSONProtocolTests {
    struct MockJSONModel: JSONParser {
        var mockField = ""
        init(json: JSON?) throws {
            guard let mockField = json?["test"] as? String else {
                throw JSONParseError.fail
            }

            self.mockField = mockField
        }
    }
}
