import Foundation

public struct AliasesEntry: Codable {
    let smartyKey, primaryNumber, streetPredirection, streetName, streetSuffix: String?
    let streetPostdirection, cityName, stateAbbreviation, zipcode, plus4Code: String?
    
    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case primaryNumber = "primary_number"
        case streetPredirection = "street_predirection"
        case streetName = "street_name"
        case streetSuffix = "street_suffix"
        case streetPostdirection = "street_postdirection"
        case cityName = "city_name"
        case stateAbbreviation = "state_abbreviation"
        case zipcode = "zipcode"
        case plus4Code = "plus4_code"
    }
}
