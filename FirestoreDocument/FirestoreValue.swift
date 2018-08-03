import Foundation

protocol AnyRawRepresentable {
    var anyRawValue: Any { get }
}

extension AnyRawRepresentable where Self: RawRepresentable {
    var anyRawValue: Any { return rawValue }
}

// https://firebase.google.com/docs/firestore/reference/rest/v1beta1/Value
public enum FirestoreValue: AutoEquatable {
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter
    }()
    
    enum CodingKeys: CodingKey {
        case nullValue
        case booleanValue
        case integerValue
        case doubleValue
        case timestampValue
        case stringValue
        case bytesValue
        case referenceValue
        case geoPointValue
        case arrayValue
        case mapValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    case nullValue
    case booleanValue(Bool)
    case integerValue(Int)
    case doubleValue(Double)
    case timestampValue(String)
    case stringValue(String)
    case bytesValue(String)
    case referenceValue(String)
    case geoPointValue(FirestoreGeoPointValue)
    case arrayValue(FirestoreArrayValue)
    case mapValue(FirestoreDocument)
    
    public init?(_ value: Any) {
        switch value {
        case nil:
            self = .nullValue
        case let array as [Any]:
            self = .arrayValue(FirestoreArrayValue(values: array.compactMap(FirestoreValue.init)))
        case let bool as Bool:
            self = .booleanValue(bool)
        case let int as Int:
            self = .integerValue(int)
        case let double as Double:
            self = .doubleValue(double)
        case let date as Date:
            self = .timestampValue(FirestoreValue.dateFormatter.string(from: date))
        case let string as String:
            self = .stringValue(string)
        case let url as URL:
            self = .stringValue(url.absoluteString)
        case let rawRepresentable as AnyRawRepresentable:
            self = FirestoreValue(rawRepresentable.anyRawValue)!
        case let geoPointValue as FirestoreGeoPointValue:
            self = .geoPointValue(geoPointValue)
        default:
            let mirror = Mirror(reflecting: value)
            guard let displayStyle = mirror.displayStyle else { return nil }
            switch displayStyle {
            case .struct:
                self = .mapValue(FirestoreDocument(value))
            case .optional:
                if mirror.children.isEmpty { return nil }
                let (_, some) = mirror.children.first!
                self = FirestoreValue(some)!
            default:
                print("unknown display style of \(displayStyle) for \(value)")
                return nil
            }
        }
    }
}

extension FirestoreValue: Decodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else {
            throw CodingError.unknownValue
        }
        
        switch key {
        case .nullValue:
            self = .nullValue
        case .booleanValue:
            self = .booleanValue(try container.decode(Bool.self, forKey: key))
        case .integerValue:
            self = .integerValue(try container.decode(Int.self, forKey: key))
        case .doubleValue:
            self = .doubleValue(try container.decode(Double.self, forKey: key))
        case .timestampValue:
            self = .timestampValue(try container.decode(String.self, forKey: key))
        case .stringValue:
            self = .stringValue(try container.decode(String.self, forKey: key))
        case .bytesValue:
            self = .bytesValue(try container.decode(String.self, forKey: key))
        case .referenceValue:
            self = .referenceValue(try container.decode(String.self, forKey: key))
        case .geoPointValue:
            self = .geoPointValue(try container.decode(FirestoreGeoPointValue.self, forKey: key))
        case .arrayValue:
            self = .arrayValue(try container.decode(FirestoreArrayValue.self, forKey: key))
        case .mapValue:
            self = .mapValue(try container.decode(FirestoreDocument.self, forKey: key))
        }
    }
}

extension FirestoreValue: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .nullValue:
            try container.encodeNil(forKey: .nullValue)
        case .booleanValue(let value):
            try container.encode(value, forKey: .booleanValue)
        case .integerValue(let value):
            try container.encode(value, forKey: .integerValue)
        case .doubleValue(let value):
            try container.encode(value, forKey: .doubleValue)
        case .timestampValue(let value):
            try container.encode(value, forKey: .timestampValue)
        case .stringValue(let value):
            try container.encode(value, forKey: .stringValue)
        case .bytesValue(let value):
            try container.encode(value, forKey: .bytesValue)
        case .referenceValue(let value):
            try container.encode(value, forKey: .referenceValue)
        case .geoPointValue(let value):
            try container.encode(value, forKey: .geoPointValue)
        case .arrayValue(let value):
            try container.encode(value, forKey: .arrayValue)
        case .mapValue(let value):
            try container.encode(value, forKey: .mapValue)
        }
    }
}
