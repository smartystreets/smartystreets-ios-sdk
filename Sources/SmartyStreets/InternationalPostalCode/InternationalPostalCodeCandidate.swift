import Foundation

@objcMembers public class InternationalPostalCodeCandidate: NSObject, Codable {
    //    A candidate is a possible match for a postal code lookup that was submitted.
    //
    //    See "https://smartystreets.com/docs/international-postal-code-api"
    
    public var inputID: String?
    public var administrativeArea: String?
    public var subAdministrativeArea: String?
    public var superAdministrativeArea: String?
    public var countryIso3: String?
    public var locality: String?
    public var dependentLocality: String?
    public var dependentLocalityName: String?
    public var doubleDependentLocality: String?
    public var postalCode: String?
    public var postalCodeExtra: String?
    
    enum CodingKeys: String, CodingKey {
        case inputID = "input_id"
        case administrativeArea = "administrative_area"
        case subAdministrativeArea = "sub_administrative_area"
        case superAdministrativeArea = "super_administrative_area"
        case countryIso3 = "country_iso_3"
        case locality = "locality"
        case dependentLocality = "dependent_locality"
        case dependentLocalityName = "dependent_locality_name"
        case doubleDependentLocality = "double_dependent_locality"
        case postalCode = "postal_code"
        case postalCodeExtra = "postal_code_extra"
    }
    
    init(dictionary: NSDictionary) {
        self.inputID = dictionary["input_id"] as? String
        self.administrativeArea = dictionary["administrative_area"] as? String
        self.subAdministrativeArea = dictionary["sub_administrative_area"] as? String
        self.superAdministrativeArea = dictionary["super_administrative_area"] as? String
        self.countryIso3 = dictionary["country_iso_3"] as? String
        self.locality = dictionary["locality"] as? String
        self.dependentLocality = dictionary["dependent_locality"] as? String
        self.dependentLocalityName = dictionary["dependent_locality_name"] as? String
        self.doubleDependentLocality = dictionary["double_dependent_locality"] as? String
        self.postalCode = dictionary["postal_code"] as? String
        self.postalCodeExtra = dictionary["postal_code_extra"] as? String
    }
}

