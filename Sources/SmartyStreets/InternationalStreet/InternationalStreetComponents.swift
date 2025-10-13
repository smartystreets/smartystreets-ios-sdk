import Foundation

@objcMembers public class InternationalStreetComponents: NSObject, Codable {
    // See "https://smartystreets.com/docs/cloud/international-street-api#components"
    
    public var countryIso3:String?
    public var superAdministrativeArea:String?
    public var administrativeArea:String?
    public var administrativeAreaISO2:String?
    public var administrativeAreaShort:String?
    public var administrativeAreaLong:String?
    public var subAdministrativeArea:String?
    public var dependentLocality:String?
    public var dependentLocalityName:String?
    public var doubleDependentLocality:String?
    public var locality:String?
    public var postalCode:String?
    public var postalCodeShort:String?
    public var postalCodeExtra:String?
    public var premise:String?
    public var premiseExtra:String?
    public var premiseNumber:String?
    public var premisePrefixNumber:String?
    public var premiseType:String?
    public var thoroughfare:String?
    public var thoroughfarePredirection:String?
    public var thoroughfarePostdirection:String?
    public var thoroughfareName:String?
    public var thoroughfareTrailingType:String?
    public var thoroughfareType:String?
    public var dependentThoroughfare:String?
    public var dependentThoroughfarePredirection:String?
    public var dependentThoroughfarePostdirection:String?
    public var dependentThoroughfareName:String?
    public var dependentThoroughfareTrailingType:String?
    public var dependentThoroughfareType:String?
    public var building:String?
    public var buildingLeadingType:String?
    public var buildingName:String?
    public var buildingTrailingType:String?
    public var subBuildingType:String?
    public var subBuildingNumber:String?
    public var subBuildingName:String?
    public var subBuilding:String?
    public var levelType:String?
    public var levelNumber:String?
    public var postBox:String?
    public var postBoxType:String?
    public var postBoxNumber:String?
    public var additionalContent:String?
    public var deliveryInstallation:String?
    public var deliveryInstallationType:String?
    public var deliveryInstallationQualifierName:String?
    public var route:String?
    public var routeNumber:String?
    public var routeType:String?

    enum CodingKeys: String, CodingKey {
        case countryIso3 = "country_iso_3"
        case superAdministrativeArea = "super_administrative_area"
        case administrativeArea = "administrative_area"
        case administrativeAreaISO2 = "administrative_area_iso2"
        case administrativeAreaShort = "administrative_area_short"
        case administrativeAreaLong = "administrative_area_long"
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
        case levelType = "level_type"
        case levelNumber = "level_number"
        case postBox = "post_box"
        case postBoxType = "post_box_type"
        case postBoxNumber = "post_box_number"
        case additionalContent = "additional_content"
        case deliveryInstallation = "delivery_installation"
        case deliveryInstallationType = "delivery_installation_type"
        case deliveryInstallationQualifierName = "delivery_installation_qualifier_name"
        case route = "route"
        case routeNumber = "route_number"
        case routeType = "route_type"
    }
    
    init(dictionary:NSDictionary) {
        self.countryIso3 = dictionary["country_iso_3"] as? String
        self.superAdministrativeArea = dictionary["super_administrative_area"] as? String
        self.administrativeArea = dictionary["administrative_area"] as? String
        self.administrativeAreaISO2 = dictionary["administrative_area_iso2"] as? String
        self.administrativeAreaShort = dictionary["administrative_area_short"] as? String
        self.administrativeAreaLong = dictionary["administrative_area_long"] as? String
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
        self.levelType = dictionary["level_type"] as? String
        self.levelNumber = dictionary["level_number"] as? String
        self.postBox = dictionary["post_box"] as? String
        self.postBoxType = dictionary["post_box_type"] as? String
        self.postBoxNumber = dictionary["post_box_number"] as? String
        self.additionalContent = dictionary["additional_content"] as? String
        self.deliveryInstallation = dictionary["delivery_installation"] as? String
        self.deliveryInstallationType = dictionary["delivery_installation_type"] as? String
        self.deliveryInstallationQualifierName = dictionary["delivery_installation_qualifier_name"] as? String
        self.route = dictionary["route"] as? String
        self.routeNumber = dictionary["route_number"] as? String
        self.routeType = dictionary["route_type"] as? String
    }
}
