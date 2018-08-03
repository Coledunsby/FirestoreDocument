import Foundation

public struct FirestoreArrayValue: Codable, Equatable {
    public var values: [FirestoreValue]
}
