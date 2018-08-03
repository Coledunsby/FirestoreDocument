import Foundation

// https://firebase.google.com/docs/firestore/reference/rest/v1beta1/projects.databases.documents
public struct FirestoreDocument: Codable, Equatable {
    
    public typealias Fields = [String: FirestoreValue]
    
    public var name: String?
    public var fields: Fields
    public var createTime: String?
    public var updateTime: String?
    
    init(_ value: Any) {
        fields = Mirror(reflecting: value).children.reduce(into: Fields()) { result, next in
            guard let key = next.label else { return }
            result[key] = FirestoreValue(next.value)
        }
    }
    
    init(fields: Fields) {
        self.fields = fields
    }
}
