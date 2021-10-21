import Foundation

@objcMembers public class InternationalAutocompleteCandidate: NSObject, Codable {
    //    A candidate is a possible match for an address that was submitted.
    //
    //    See "https://smartystreets.com/docs/cloud/international-address-autocomplete-api"
    
    public var street:String?
    public var locality:String?
    public var administrativeArea:String?
    public var postalCode:String?
    public var countryISO3:String?
    
    enum CodingKeys:String, CodingKey {
        case street = "street"
        case locality = "locality"
        case administrativeArea = "administrative_area"
        case postalCode = "postal_code"
        case countryISO3 = "country_iso3"
    }
    
    init(dictionary:NSDictionary) {
        self.street = dictionary["street"] as? String
        self.locality = dictionary["locality"] as? String
        self.administrativeArea = dictionary["administrative_area"] as? String
        self.postalCode = dictionary["postal_code"] as? String
        self.countryISO3 = dictionary["country_iso3"] as? String
    }
}
