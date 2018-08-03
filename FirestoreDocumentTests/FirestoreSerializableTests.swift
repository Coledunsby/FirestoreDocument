@testable import FirestoreDocument
import Nimble
import XCTest

final class FirestoreSerializableTests: XCTestCase {
    
    func testInitSuccess() throws {
        let document = FirestoreDocument(fields: [
            "name": .stringValue("John Doe"),
            "age": .integerValue(30)
        ])
        let user = try User(firestoreDocument: document)
        let expected = User(name: "John Doe", age: 30, maybe: nil)
        expect(user) == expected
    }
    
    func testInitMissing() throws {
        let document = FirestoreDocument(fields: [
            "name": .stringValue("John Doe")
        ])
        do {
            _ = try User(firestoreDocument: document)
            fail("should error with missing field")
        } catch {
            expect(error as? FirestoreSerializationError) == .missing
        }
    }
    
    func testInitWrongType() throws {
        let document = FirestoreDocument(fields: [
            "name": .stringValue("John Doe"),
            "age": .booleanValue(true)
        ])
        do {
            _ = try User(firestoreDocument: document)
            fail("should error with wrong type")
        } catch {
            expect(error as? FirestoreSerializationError) == .wrongType
        }
    }
}
