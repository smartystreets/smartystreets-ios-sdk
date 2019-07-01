import Foundation

@objcMembers class USStreetMetadata:NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-street-api#metadata"
    
    var recordType:String?
    var zipType:String?
    var countyFips:String?
    var countyName:String?
    var carrierRoute:String?
    var congressionalDistrict:String?
    var buildingDefaultIndicator:String?
    var rdi:String?
    var elotSequence:String?
    var elotSort:String?
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
    var precision:String?
    var timeZone:String?
    var utcOffset:Double?
    public var objcUtcOffset:NSNumber? {
        get {
            return utcOffset as NSNumber?
        }
    }
    var obeysDst:Bool?
    public var objcObeysDst:NSNumber? {
        get {
            return obeysDst as NSNumber?
        }
    }
    var isEwsMatch:Bool?
    public var objcIsEwsMatch:NSNumber? {
        get {
            return isEwsMatch as NSNumber?
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case recordType = "record_type"
        case zipType = "zip_type"
        case countyFips = "county_fips"
        case countyName = "county_name"
        case carrierRoute = "carrier_route"
        case congressionalDistrict = "congressional_district"
        case buildingDefaultIndicator = "building_default_indicator"
        case rdi = "rdi"
        case elotSequence = "elot_sequence"
        case elotSort = "elot_sort"
        case latitude = "latitude"
        case longitude = "longitude"
        case precision = "precision"
        case timeZone = "time_zone"
        case utcOffset = "utc_offset"
        case obeysDst = "dst"
        case isEwsMatch = "ews_match"
    }
    
    init(dictionary: NSDictionary) {
        self.recordType = dictionary["record_type"] as? String
        self.zipType = dictionary["zip_type"] as? String
        self.countyFips = dictionary["county_fips"] as? String
        self.countyName = dictionary["county_name"] as? String
        self.carrierRoute = dictionary["carrier_route"] as? String
        self.congressionalDistrict = dictionary["congressional_district"] as? String
        self.buildingDefaultIndicator = dictionary["building_default_indicator"] as? String
        self.rdi = dictionary["rdi"] as? String
        self.elotSequence = dictionary["elot_sequence"] as? String
        self.elotSort = dictionary["elot_sort"] as? String
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.precision = dictionary["precision"] as? String
        self.timeZone = dictionary["time_zone"] as? String
        self.utcOffset = dictionary["utc_offset"] as? Double
        self.obeysDst = dictionary["dst"] as? Bool
        self.isEwsMatch = dictionary["ews_match"] as? Bool
    }
}
