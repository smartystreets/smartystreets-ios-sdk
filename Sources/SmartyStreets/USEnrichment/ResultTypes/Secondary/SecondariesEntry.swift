import Foundation

public struct SecondariesEntry: Codable {
    let smartyKey, secondaryDesignator, secondaryNumber, plus4Code: String?
    
    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case secondaryDesignator = "secondary_designator"
        case secondaryNumber = "secondary_number"
        case plus4Code = "plus4_code"
    }
}
