import Foundation

@objcMembers public class USStreetMatchInfo: NSObject, Codable {
    public var status: String?
    public var changes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case changes = "changes"
    }
    
    init(dictionary: NSDictionary) {
        self.status = dictionary["status"] as? String
        self.changes = dictionary["changes"] as? [String]
    }
}

@objcMembers public class USStreetComponentAnalysis: NSObject, Codable {
    // Analysis components related to each element of the address
    
    public var primaryNumber: USStreetMatchInfo?
    public var streetName: USStreetMatchInfo?
    public var streetPredirection: USStreetMatchInfo?
    public var streetPostdirection: USStreetMatchInfo?
    public var streetSuffix: USStreetMatchInfo?
    public var secondaryNumber: USStreetMatchInfo?
    public var secondaryDesignator: USStreetMatchInfo?
    public var extraSecondaryNumber: USStreetMatchInfo?
    public var extraSecondaryDesignator: USStreetMatchInfo?
    public var cityName: USStreetMatchInfo?
    public var stateAbbreviation: USStreetMatchInfo?
    public var zipcode: USStreetMatchInfo?
    public var plus4Code: USStreetMatchInfo?
    
    enum CodingKeys: String, CodingKey {
        case primaryNumber = "primary_number"
        case streetName = "street_name"
        case streetPredirection = "street_predirection"
        case streetPostdirection = "street_postdirection"
        case streetSuffix = "street_suffix"
        case secondaryNumber = "secondary_number"
        case secondaryDesignator = "secondary_designator"
        case extraSecondaryNumber = "extra_secondary_number"
        case extraSecondaryDesignator = "extra_secondary_designator"
        case cityName = "city_name"
        case stateAbbreviation = "state_abbreviation"
        case zipcode = "zipcode"
        case plus4Code = "plus4_code"
    }
    
    init(dictionary: NSDictionary) {
        if let componentsDict = dictionary as? [String: Any] {
            self.primaryNumber = componentsDict["primary_number"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.streetName = componentsDict["street_name"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.streetPredirection = componentsDict["street_predirection"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.streetPostdirection = componentsDict["street_postdirection"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.streetSuffix = componentsDict["street_suffix"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.secondaryNumber = componentsDict["secondary_number"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.secondaryDesignator = componentsDict["secondary_designator"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.extraSecondaryNumber = componentsDict["extra_secondary_number"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.extraSecondaryDesignator = componentsDict["extra_secondary_designator"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.cityName = componentsDict["city_name"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.stateAbbreviation = componentsDict["state_abbreviation"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.zipcode = componentsDict["zipcode"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
            self.plus4Code = componentsDict["plus4_code"].flatMap { USStreetMatchInfo(dictionary: $0 as! NSDictionary) }
        }
    }
}
