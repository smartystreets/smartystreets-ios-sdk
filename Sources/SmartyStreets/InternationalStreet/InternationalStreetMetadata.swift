import Foundation

@objcMembers public class InternationalStreetMetadata: NSObject, Codable {
    // See "https://smartystreets.com/docs/cloud/international-street-api#metadata"
    
    public var latitude:Double?
    public var objcLatitude:NSNumber? {
        get {
            return latitude as NSNumber?
        }
    }
    public var longitude:Double?
    public var objcLongitude:NSNumber? {
        get {
            return longitude as NSNumber?
        }
    }
    public var geocodePrecision:String?
    public var maxGeocodePrecision:String?
    public var addressFormat:String?
    public var occupantUse:String?

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case geocodePrecision = "geocode_precision"
        case maxGeocodePrecision = "max_geocode_precision"
        case addressFormat = "address_format"
        case occupantUse = "occupant_use"
    }
    
    init(dictionary: NSDictionary) {
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.geocodePrecision = dictionary["geocode_precision"] as? String
        self.maxGeocodePrecision = dictionary["max_geocode_precision"] as? String
        self.addressFormat = dictionary["address_format"] as? String
        self.occupantUse = dictionary["occupant_use"] as? String
    }
}
