import Foundation

@objcMembers class InternationalStreetLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain the
    //    result of the lookup after it comes back from the API.
    //
    //    Note: Lookups must have certain required fields set with non-blank values.
    //
    //    See "https://smartystreets.com/docs/cloud/international-street-api#http-input-fields"
    //
    //    self.geocode: Disabled by default. Set to true to enable.
    //    self.language: When not set, the output language will match the language of the input values.
    //    When set to language_mode.Native, the results will always be in the language of the output country.
    //    When set to language_mode.Latin, the results will always be provided using a Latin character set.
    
    var result:[InternationalStreetCandidate]?
    var inputId:String?
    var country:String?
    var geocode:String?
    
    var language:LanguageMode?
    var freeform:String?
    var address1:String?
    var address2:String?
    var address3:String?
    var address4:String?
    var organization:String?
    var locality:String?
    var administrativeArea:String?
    var postalCode:String?
    
    override init() {    }
    
    init(freeform:String, country:String, inputId:String?) {
        self.freeform = freeform
        self.country = country
        self.inputId = inputId
    }
    
    init(address1:String, postalCode:String, country:String, inputId:String?) {
        self.address1 = address1
        self.postalCode = postalCode
        self.country = country
        self.inputId = inputId
    }
    
    init(address1:String, locality:String, administrativeArea:String, country:String, inputId:String?) {
        self.address1 = address1
        self.locality = locality
        self.administrativeArea = administrativeArea
        self.country = country
        self.inputId = inputId
    }
    
    func missingCountry() -> Bool {
        return fieldIsMissing(field: self.country)
    }
    
    func hasFreeform() -> Bool {
        return fieldIsSet(field: self.freeform)
    }
    
    func missingAddress1() -> Bool {
        return fieldIsMissing(field: self.address1)
    }
    
    func hasPostalCode() -> Bool {
        return fieldIsSet(field: self.postalCode)
    }
    
    func missingLocalityOrAdministrativeArea() -> Bool {
        return fieldIsMissing(field: self.locality) || fieldIsMissing(field: self.administrativeArea)
    }
    
    func fieldIsSet(field:String?) -> Bool {
        return !fieldIsMissing(field: field)
    }
    
    func fieldIsMissing(field:String?) -> Bool {
        if let field = field {
            return field.count == 0
        } else {
            return true
        }
    }
    
    func getResultAtIndex(index:Int) -> InternationalStreetCandidate {
        if let results = self.result {
            return results[index]
        } else {
            return InternationalStreetCandidate(dictionary: NSDictionary())
        }
    }
    
    func enableGeocode(geocode:Bool) {
        if geocode {
            self.geocode = "true"
        } else {
            self.geocode = "false"
        }
    }
}
