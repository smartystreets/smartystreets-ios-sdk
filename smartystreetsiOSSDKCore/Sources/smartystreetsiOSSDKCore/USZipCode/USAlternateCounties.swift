import Foundation

public class USAlternateCounties: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-zipcode-api#zipcodes"
    
    public var countyFips:String?
    public var countyName:String?
    public var stateAbbreviation:String?
    public var state:String?
    
    enum CodingKeys: String, CodingKey {
        case countyFips = "county_fips"
        case countyName = "county_name"
        case stateAbbreviation = "state_abbreviation"
        case state = "state"
    }
    
    public init(dictionary:NSDictionary) {
        self.countyFips = dictionary["county_fips"] as? String
        self.countyName = dictionary["county_name"] as? String
        self.stateAbbreviation = dictionary["state_abbreviation"] as? String
        self.state = dictionary["state"] as? String
    }
}
