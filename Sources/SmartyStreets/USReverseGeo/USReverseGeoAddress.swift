import Foundation

@objcMembers public class USReverseGeoAddress: NSObject, Codable {
    public var street:String?
    public var city:String?
    public var stateAbbreviation:String?
    public var zipcode:String?
    
    init(dictionary: NSDictionary) {
        self.street = dictionary["street"] as? String
        self.city = dictionary["city"] as? String
        self.stateAbbreviation = dictionary["state_abbreviation"] as? String
        self.zipcode = dictionary["zipcode"] as? String
    }
}
