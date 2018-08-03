import Foundation

enum FirestoreSerializationError: Error {
    case missing
    case wrongType
}

protocol FirestoreSerializable {
    init(firestoreDocument: FirestoreDocument) throws
    var firestoreDocument: FirestoreDocument { get }
}

extension FirestoreSerializable {
    var firestoreDocument: FirestoreDocument {
        return .init(self)
    }
}

extension FirestoreDocument {
    
    func value<T>(for field: String) throws -> T {
        guard let firestoreValue = fields[field] else { throw FirestoreSerializationError.missing }
        guard let value = firestoreValue.value as? T else { throw FirestoreSerializationError.wrongType }
        return value
    }
}

extension FirestoreValue {
    
    public var value: Any? {
        switch self {
        case .nullValue:
            return nil
        case .booleanValue(let value):
            return value
        case .integerValue(let value):
            return value
        case .doubleValue(let value):
            return value
        case .timestampValue(let value):
            return value
        case .stringValue(let value):
            return value
        case .bytesValue(let value):
            return value
        case .referenceValue(let value):
            return value
        case .geoPointValue(let value):
            return value
        case .arrayValue(let value):
            return value
        case .mapValue(let value):
            return value
        }
    }
}
