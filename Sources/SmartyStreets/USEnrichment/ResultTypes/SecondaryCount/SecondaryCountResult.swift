import Foundation

public struct SecondaryCountResult: Codable {
    public let smartyKey: String?
    public let count: Int?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case count = "count"
    }
}
