import Foundation

@objcMembers public class USAutocompleteSuggestion: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-autocomplete-api#http-response"
    
    public var text:String?
    public var streetLine:String?
    public var city:String?
    public var state:String?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case streetLine = "street_line"
        case city = "city"
        case state = "state"
    }
    init(dictionary: NSDictionary) {
        self.text = dictionary["text"] as? String
        self.streetLine = dictionary["street_line"] as? String
        self.city = dictionary["city"] as? String
        self.state = dictionary["state"] as? String
    }
}
