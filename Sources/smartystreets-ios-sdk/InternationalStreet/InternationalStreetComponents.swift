import Foundation

@objcMembers class InternationalStreetComponents: NSObject, Codable {
    // See "https://smartystreets.com/docs/cloud/international-street-api#components"
    
    var countryIso3:String?
    var superAdministrativeArea:String?
    var administrativeArea:String?
    var subAdministrativeArea:String?
    var dependentLocality:String?
    var dependentLocalityName:String?
    var doubleDependentLocality:String?
    var locality:String?
    var postalCode:String?
    var postalCodeShort:String?
    var postalCodeExtra:String?
    var premise:String?
    var premiseExtra:String?
    var premiseNumber:String?
    var premisePrefixNumber:String?
    var premiseType:String?
    var thoroughfare:String?
    var thoroughfarePredirection:String?
    var thoroughfarePostdirection:String?
    var thoroughfareName:String?
    var thoroughfareTrailingType:String?
    var thoroughfareType:String?
    var dependentThoroughfare:String?
    var dependentThoroughfarePredirection:String?
    var dependentThoroughfarePostdirection:String?
    var dependentThoroughfareName:String?
    var dependentThoroughfareTrailingType:String?
    var dependentThoroughfareType:String?
    var building:String?
    var buildingLeadingType:String?
    var buildingName:String?
    var buildingTrailingType:String?
    var subBuildingType:String?
    var subBuildingNumber:String?
    var subBuildingName:String?
    var subBuilding:String?
    var postBox:String?
    var postBoxType:String?
    var postBoxNumber:String?
    
    enum CodingKeys: String, CodingKey {
        case countryIso3 = "country_iso_3"
        case superAdministrativeArea = "super_administrative_area"
        case administrativeArea = "administrative_area"
        case subAdministrativeArea = "sub_administrative_area"
        case dependentLocality = "dependent_locality"
        case dependentLocalityName = "dependent_locality_name"
        case doubleDependentLocality = "double_dependent_locality"
        case locality = "locality"
        case postalCode = "postal_code"
        case postalCodeShort = "postal_code_short"
        case postalCodeExtra = "postal_code_extra"
        case premise = "premise"
        case premiseExtra = "premise_extra"
        case premiseNumber = "premise_number"
        case premisePrefixNumber = "premise_prefix_number"
        case premiseType = "premise_type"
        case thoroughfare = "thoroughfare"
        case thoroughfarePredirection = "thoroughfare_predirection"
        case thoroughfarePostdirection = "thoroughfare_postdirection"
        case thoroughfareName = "thoroughfare_name"
        case thoroughfareTrailingType = "thoroughfare_trailint_type"
        case thoroughfareType = "thoroughfare_type"
        case dependentThoroughfare = "dependent_thoroughfare"
        case dependentThoroughfarePredirection = "dependent_thoroughfare_predirection"
        case dependentThoroughfarePostdirection = "dependent_thoroughfare_postdirection"
        case dependentThoroughfareName = "dependent_thoroughfare_name"
        case dependentThoroughfareTrailingType = "dependent_thoroughfare_trailing_type"
        case dependentThoroughfareType = "dependent_thoroughfare_type"
        case building = "building"
        case buildingLeadingType = "building_leading_type"
        case buildingName = "building_name"
        case buildingTrailingType = "building_trailing_type"
        case subBuildingType = "sub_building_type"
        case subBuildingNumber = "sub_building_number"
        case subBuildingName = "sub_building_name"
        case subBuilding = "sub_building"
        case postBox = "post_box"
        case postBoxType = "post_box_type"
        case postBoxNumber = "post_box_number"
    }
    
    init(dictionary:NSDictionary) {
        self.countryIso3 = dictionary["country_iso_3"] as? String
        self.superAdministrativeArea = dictionary["super_administrative_area"] as? String
        self.administrativeArea = dictionary["administrative_area"] as? String
        self.subAdministrativeArea = dictionary["sub_administrative_area"] as? String
        self.dependentLocality = dictionary["dependent_locality"] as? String
        self.dependentLocalityName = dictionary["dependent_locality_name"] as? String
        self.doubleDependentLocality = dictionary["double_dependent_locality"] as? String
        self.locality = dictionary["locality"] as? String
        self.postalCode = dictionary["postal_code"] as? String
        self.postalCodeShort = dictionary["postal_code_short"] as? String
        self.postalCodeExtra = dictionary["postal_code_extra"] as? String
        self.premise = dictionary["premise"] as? String
        self.premiseExtra = dictionary["premise_extra"] as? String
        self.premiseNumber = dictionary["premise_number"] as? String
        self.premisePrefixNumber = dictionary["premise_prefix_number"] as? String
        self.premiseType = dictionary["premise_type"] as? String
        self.thoroughfare = dictionary["thoroughfare"] as? String
        self.thoroughfarePredirection = dictionary["thoroughfare_predirection"] as? String
        self.thoroughfarePostdirection = dictionary["thoroughfare_postdirection"] as? String
        self.thoroughfareName = dictionary["thoroughfare_name"] as? String
        self.thoroughfareTrailingType = dictionary["thoroughfare_trailing_type"] as? String
        self.thoroughfareType = dictionary["thoroughfare_type"] as? String
        self.dependentThoroughfare = dictionary["dependent_thoroughfare"] as? String
        self.dependentThoroughfarePredirection = dictionary["dependent_thoroughfare_predirection"] as? String
        self.dependentThoroughfarePostdirection = dictionary["dependent_thoroughfare_postdirection"] as? String
        self.dependentThoroughfareName = dictionary["dependent_thoroughfare_name"] as? String
        self.dependentThoroughfareTrailingType = dictionary["dependent_thoroughfare_trailing_type"] as? String
        self.dependentThoroughfareType = dictionary["dependent_thoroughfare_type"] as? String
        self.building = dictionary["building"] as? String
        self.buildingLeadingType = dictionary["building_leading_type"] as? String
        self.buildingName = dictionary["building_name"] as? String
        self.buildingTrailingType = dictionary["building_trailing_type"] as? String
        self.subBuildingType = dictionary["sub_building_type"] as? String
        self.subBuildingNumber = dictionary["sub_building_number"] as? String
        self.subBuildingName = dictionary["sub_building_name"] as? String
        self.subBuilding = dictionary["sub_building"] as? String
        self.postBox = dictionary["post_box"] as? String
        self.postBoxType = dictionary["post_box_type"] as? String
        self.postBoxNumber = dictionary["post_box_number"] as? String
    }
}
