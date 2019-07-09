import Foundation

@objcMembers public class USCity: NSObject, Codable {
    //    Known in the SmartyStreets US ZIP Code API documentation as a city_state
    //    See "https://smartystreets.com/docs/cloud/us-zipcode-api#cities"
    
    public var city:String?
    public var mailablecity:Bool?
    public var objcMailableCity:NSNumber? {
        get {
            return mailablecity as NSNumber?;
        }
    }
    public var stateAbbreviation:String?
    public var state:String?
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case mailablecity = "mailable_city"
        case stateAbbreviation = "state_abbreviation"
        case state = "state"
    }
    
    public init(dictionary:NSDictionary) {
        self.city = dictionary["city"] as? String
        self.mailablecity = dictionary["mailable_city"] as? Bool
        self.stateAbbreviation = dictionary["state_abbreviation"] as? String
        self.state = dictionary["state"] as? String
    }
}
