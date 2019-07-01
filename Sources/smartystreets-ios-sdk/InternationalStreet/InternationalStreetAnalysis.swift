import Foundation

@objcMembers class InternationalStreetAnalysis: NSObject, Codable {
    // See "https://smartystreets.com/docs/cloud/international-street-api#analysis"
    
    var verificationStatus:String?
    var addressPrecision:String?
    var maxAddressPrecision:String?
    var changes:InternationalStreetChanges?
    
    init(dictionary: NSDictionary) {
        self.verificationStatus = dictionary["verification_status"] as? String
        self.addressPrecision = dictionary["address_precision"] as? String
        self.maxAddressPrecision = dictionary["max_address_precision"] as? String
        if let changes = dictionary["changes"] {
            self.changes = InternationalStreetChanges(dictionary: changes as! NSDictionary)
        } else {
            self.changes = InternationalStreetChanges(dictionary: NSDictionary())
        }
    }
}
