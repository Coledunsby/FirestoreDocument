@testable import FirestoreDocument
import Foundation
import XCTest

struct User: Equatable {
    var name: String
    var age: Int
    var maybe: Bool?
}

extension User: FirestoreSerializable {
    
    init(firestoreDocument: FirestoreDocument) throws {
        name = try firestoreDocument.value(for: "name")
        age = try firestoreDocument.value(for: "age")
        maybe = try? firestoreDocument.value(for: "maybe")
    }
}


extension XCTestCase {
    
    @discardableResult
    func decode(_ json: String) throws -> FirestoreDocument {
        let data = json.data(using: .utf8)!
        return try JSONDecoder().decode(FirestoreDocument.self, from: data)
    }
}
