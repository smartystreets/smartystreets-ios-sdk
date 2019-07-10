import Foundation

@objcMembers public class USZipCode: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-zipcode-api#zipcodes"
    
    public var zipCode:String?
    public var zipCodeType:String?
    public var defaultCity:String?
    public var countyFips:String?
    public var countyName:String?
    public var stateAbbreviation:String?
    public var state:String?
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
    public var precision:String?
    public var alternateCounties:[USAlternateCounties]?
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zipcode"
        case zipCodeType = "zipcode_type"
        case defaultCity = "default_city"
        case countyFips = "county_fips"
        case countyName = "county_name"
        case stateAbbreviation = "state_abbreviation"
        case state = "state"
        case latitude = "latitude"
        case longitude = "longitude"
        case precision = "precision"
        case alternateCounties = "alternate_counties"
    }
    
    public init(dictionary:NSDictionary) {
        super.init()
        self.zipCode = dictionary["zipcode"] as? String
        self.zipCodeType = dictionary["zipcode_type"] as? String
        self.defaultCity = dictionary["default_city"] as? String
        self.countyFips = dictionary["county_fips"] as? String
        self.countyName = dictionary["county_name"] as? String
        self.stateAbbreviation = dictionary["state_abbreviation"] as? String
        self.state = dictionary["state"] as? String
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.precision = dictionary["precision"] as? String
        if let alternateCounties = dictionary["alternate_counties"] {
            self.alternateCounties = convertToAlternateCountyObjects(alternateCounties as! [[String:String]])
        } else {
            self.alternateCounties = [USAlternateCounties]()
        }
    }
    
    func convertToAlternateCountyObjects(_ object: [[String:String]]) -> [USAlternateCounties] {
        var mutable = [USAlternateCounties]()
        for alternateCity in object {
            mutable.append(USAlternateCounties(dictionary: alternateCity as NSDictionary))
        }
        return mutable
    }
    
    func getAlternateCountiesAtIndex(index:Int) -> USAlternateCounties {
        if let alternateCounty = self.alternateCounties?[index] {
            return alternateCounty
        } else {
            return USAlternateCounties(dictionary: NSDictionary())
        }
    }
}
