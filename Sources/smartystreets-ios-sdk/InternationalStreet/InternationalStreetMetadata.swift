import Foundation

@objcMembers class InternationalStreetMetadata: NSObject, Codable {
    // See "https://smartystreets.com/docs/cloud/international-street-api#metadata"
    
    var latitude:Double?
    public var objcLatitude:NSNumber? {
        get {
            return latitude as NSNumber?
        }
    }
    var longitude:Double?
    public var objcLongitude:NSNumber? {
        get {
            return longitude as NSNumber?
        }
    }
    var geocodePrecision:String?
    var maxGeocodePrecision:String?
    var addressFormat:String?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case geocodePrecision = "geocode_precision"
        case maxGeocodePrecision = "max_geocode_precision"
        case addressFormat = "address_format"
    }
    
    init(dictionary: NSDictionary) {
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.geocodePrecision = dictionary["geocode_precision"] as? String
        self.maxGeocodePrecision = dictionary["max_geocode_precision"] as? String
        self.addressFormat = dictionary["address_format"] as? String
    }
}
