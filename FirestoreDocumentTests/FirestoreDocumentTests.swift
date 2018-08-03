@testable import FirestoreDocument
import Nimble
import XCTest

final class FirestoreDocumentTests: XCTestCase {
    
    func testDecodeNullValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "nullValue": null
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .nullValue
    }
    
    func testDecodeBooleanValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "booleanValue": true
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .booleanValue(true)
    }
    
    func testDecodeIntegerValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "integerValue": 5
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .integerValue(5)
    }
    
    func testDecodeDoubleValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "doubleValue": 5.5
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .doubleValue(5.5)
    }
    
    func testDecodeTimestampValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "timestampValue": "hello world"
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .timestampValue("hello world")
    }
    
    func testDecodeStringValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "stringValue": "hello world"
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .stringValue("hello world")
    }
    
    func testDecodeBytesValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "bytesValue": "hello world"
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .bytesValue("hello world")
    }
    
    func testDecodeReferenceValue() throws {
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "referenceValue": "hello world"
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .referenceValue("hello world")
    }
    
    func testDecodeGeoPointValue() throws {
        let geoPoint = FirestoreGeoPointValue(latitude: 1.2, longitude: 3.4)
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "geoPointValue": {
                            "latitude": \(geoPoint.latitude),
                            "longitude": \(geoPoint.longitude)
                        }
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .geoPointValue(geoPoint)
    }
    
    func testDecodeArrayValue() throws {
        let array = FirestoreArrayValue(values: [.booleanValue(true), .integerValue(10)])
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "arrayValue": {
                            "values": [
                                {
                                    "booleanValue": true
                                },
                                {
                                    "integerValue": 10
                                }
                            ]
                        }
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .arrayValue(array)
    }
    
    func testDecodeMapValue() throws {
        let map = FirestoreDocument(fields: [
            "first": .booleanValue(true),
            "second": .integerValue(10)
        ])
        let document = try decode(
            """
            {
                "fields": {
                    "test": {
                        "mapValue": {
                            "fields": {
                                "first": {
                                    "booleanValue": true
                                },
                                "second": {
                                    "integerValue": 10
                                }
                            }
                        }
                    }
                }
            }
            """
        )
        expect(document.fields["test"]) == .mapValue(map)
    }
    
    func testInitFromObject() throws {
        let user = User(name: "John Doe", age: 30, maybe: nil)
        let document = FirestoreDocument(user)
        let expected = try decode(
            """
            {
                "fields": {
                    "name": {
                        "stringValue": "John Doe"
                    },
                    "age": {
                        "integerValue": 30
                    }
                }
            }
            """
        )
        expect(document) == expected
    }
}
