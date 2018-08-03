// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs

// MARK: - AutoEquatable for Enums
// MARK: - FirestoreValue AutoEquatable
extension FirestoreValue: Equatable {}
public func == (lhs: FirestoreValue, rhs: FirestoreValue) -> Bool {
    switch (lhs, rhs) {
    case (.nullValue, .nullValue):
        return true
    case (.booleanValue(let lhs), .booleanValue(let rhs)):
        return lhs == rhs
    case (.integerValue(let lhs), .integerValue(let rhs)):
        return lhs == rhs
    case (.doubleValue(let lhs), .doubleValue(let rhs)):
        return lhs == rhs
    case (.timestampValue(let lhs), .timestampValue(let rhs)):
        return lhs == rhs
    case (.stringValue(let lhs), .stringValue(let rhs)):
        return lhs == rhs
    case (.bytesValue(let lhs), .bytesValue(let rhs)):
        return lhs == rhs
    case (.referenceValue(let lhs), .referenceValue(let rhs)):
        return lhs == rhs
    case (.geoPointValue(let lhs), .geoPointValue(let rhs)):
        return lhs == rhs
    case (.arrayValue(let lhs), .arrayValue(let rhs)):
        return lhs == rhs
    case (.mapValue(let lhs), .mapValue(let rhs)):
        return lhs == rhs
    default: return false
    }
}
