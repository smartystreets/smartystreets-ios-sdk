import Foundation

public struct SecondaryResult: Codable {
    public let smartyKey: String?
    public let rootAddress: RootAddressEntry?
    public let aliases: [RootAddressEntry]?
    public let secondaries: [SecondariesEntry]?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case rootAddress = "root_address"
        case aliases = "aliases"
        case secondaries = "secondaries"
    }
}
