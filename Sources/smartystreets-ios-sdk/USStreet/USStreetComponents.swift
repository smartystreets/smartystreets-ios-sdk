import Foundation

@objcMembers class USStreetComponents: NSObject, Codable {
    //    This class contains the matched address broken down into its fundamental pieces.
    //
    //    See "https://smartystreets.com/docs/cloud/us-street-api#components"
    
    var urbanization:String?
    var primaryNumber:String?
    var streetName:String?
    var streetPredirection:String?
    var streetPostdirection:String?
    var streetSuffix:String?
    var secondaryNumber:String?
    var secondaryDesignator:String?
    var extraSecondaryNumber:String?
    var extraSecondaryDesignator:String?
    var pmbDesignator:String?
    var pmbNumber:String?
    var cityName:String?
    var defaultCityName:String?
    var state:String?
    var zipCode:String?
    var plus4Code:String?
    var deliveryPoint:String?
    var deliveryPointCheckDigit:String?
    
    enum CodingKeys: String, CodingKey {
        case urbanization = "urbanization"
        case primaryNumber = "primary_number"
        case streetName = "street_name"
        case streetPredirection = "street_predirection"
        case streetPostdirection = "street_postdirection"
        case streetSuffix = "street_suffix"
        case secondaryNumber = "secondary_number"
        case secondaryDesignator = "secondary_designator"
        case extraSecondaryNumber = "extra_secondary_number"
        case extraSecondaryDesignator = "extra_secondary_designator"
        case pmbDesignator = "pmb_designator"
        case pmbNumber = "pmb_number"
        case cityName = "city_name"
        case defaultCityName = "default_city_name"
        case state = "state_abbreviation"
        case zipCode = "zipcode"
        case plus4Code = "plus4_code"
        case deliveryPoint = "delivery_point"
        case deliveryPointCheckDigit = "delivery_point_check_digit"
    }
    
    init(dictionary: NSDictionary) {
        self.urbanization = dictionary["urbanization"] as? String
        self.primaryNumber = dictionary["primary_number"] as? String
        self.streetName = dictionary["street_name"] as? String
        self.streetPredirection = dictionary["street_predirection"] as? String
        self.streetPostdirection = dictionary["street_postdirection"] as? String
        self.streetSuffix = dictionary["street_suffix"] as? String
        self.secondaryNumber = dictionary["secondary_number"] as? String
        self.secondaryDesignator = dictionary["secondary_designator"] as? String
        self.extraSecondaryNumber = dictionary["extra_secondary_number"] as? String
        self.extraSecondaryDesignator = dictionary["extra_secondary_designator"] as? String
        self.pmbDesignator = dictionary["pmb_designator"] as? String
        self.pmbNumber = dictionary["pmb_number"] as? String
        self.cityName = dictionary["city_name"] as? String
        self.defaultCityName = dictionary["default_city_name"] as? String
        self.state = dictionary["state_abbreviation"] as? String
        self.zipCode = dictionary["zipcode"] as? String
        self.plus4Code = dictionary["plus4_code"] as? String
        self.deliveryPoint = dictionary["delivery_point"] as? String
        self.deliveryPointCheckDigit = dictionary["delivery_point_check_digit"] as? String
    }
}
