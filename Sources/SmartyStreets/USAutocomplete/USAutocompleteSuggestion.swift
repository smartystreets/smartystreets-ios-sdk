import Foundation

@objcMembers public class USAutocompleteSuggestion: NSObject, Codable {
    //    See "https://www.smarty.com/docs/apis/us-autocomplete-v2/reference#http-response-status"

    public var smartyKey:String?
    public var entryId:String?
    public var urbanization:String?
    public var streetLine:String?
    public var secondary:String?
    public var city:String?
    public var state:String?
    public var zipcode:String?
    public var entries:Int?
    public var source:String?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case entryId = "entry_id"
        case urbanization = "urbanization"
        case streetLine = "street_line"
        case secondary = "secondary"
        case city = "city"
        case state = "state"
        case zipcode = "zipcode"
        case entries = "entries"
        case source = "source"
    }

    init(dictionary: NSDictionary) {
        self.smartyKey = dictionary["smarty_key"] as? String
        self.entryId = dictionary["entry_id"] as? String
        self.urbanization = dictionary["urbanization"] as? String
        self.streetLine = dictionary["street_line"] as? String
        self.secondary = dictionary["secondary"] as? String
        self.city = dictionary["city"] as? String
        self.state = dictionary["state"] as? String
        self.zipcode = dictionary["zipcode"] as? String
        self.entries = dictionary["entries"] as? Int
        self.source = dictionary["source"] as? String
    }
}
