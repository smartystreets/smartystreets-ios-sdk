import Foundation

@objcMembers public class USAutocompleteProSuggestion: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-autocomplete-api#http-response"
    
    public var streetLine:String?
    public var secondary:String?
    public var city:String?
    public var state:String?
    public var zipcode:String?
    public var entries:String?
    
    enum CodingKeys: String, CodingKey {
        case streetLine = "street_line"
    }
    
    init(dictionary: NSDictionary) {
        self.streetLine = dictionary["street_line"] as? String
        self.secondary = dictionary["secondary"] as? String
        self.city = dictionary["city"] as? String
        self.state = dictionary["state"] as? String
        self.zipcode = dictionary["zipcode"] as? String
        self.entries = dictionary["entries"] as? String
    }
}
