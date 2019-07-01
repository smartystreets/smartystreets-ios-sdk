import Foundation

@objcMembers class USExtractMetadata: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-extract-api#http-response-status"
    
    var lines:Int?
    var unicode:Bool?
    public var objcUnicode:NSNumber? {
        get {
            return unicode as NSNumber?
        }
    }
    var addressCount:Int?
    public var objcAddressCount:NSNumber? {
        get {
            return addressCount as NSNumber?
        }
    }
    var verifiedCount:Int?
    public var objcVerifiedCount:NSNumber? {
        get {
            return verifiedCount as NSNumber?
        }
    }
    var bytes:Int?
    public var objcBytes:NSNumber? {
        get {
            return bytes as NSNumber?
        }
    }
    var characterCount:Int?
    public var objcCharacterCount:NSNumber? {
        get {
            return characterCount as NSNumber?
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case addressCount = "address_count"
        case verifiedCount = "verified_count"
        case characterCount = "character_count"
    }
    
    init(dictionary:NSDictionary) {
        self.lines = dictionary["lines"] as? Int
        self.unicode = dictionary["unicode"] as? Bool
        self.addressCount = dictionary["address_count"] as? Int
        self.verifiedCount = dictionary["verified_count"] as? Int
        self.bytes = dictionary["bytes"] as? Int
        self.characterCount = dictionary["character_count"] as? Int
    }
    
    func isUnicode() -> Bool {
        if let unicode = self.unicode {
            return unicode
        } else {
            return false
        }
    }
}
