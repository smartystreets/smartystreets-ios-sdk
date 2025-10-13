import Foundation

public struct SecondaryCountResult: Codable {
    public let smartyKey: String?
    public let matchedAddress: MatchedAddress?
    public let count: Int?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case matchedAddress = "matched_address"
        case count = "count"
    }
}
