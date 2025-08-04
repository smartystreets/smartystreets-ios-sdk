import Foundation

public struct MatchedAddress: Codable {
    let street, city, state, zipcode: String?

    enum CodingKeys: String, CodingKey {
        case street = "street"
        case city = "city"
        case state = "state"
        case zipcode = "zipcode"
    }
}
