import Foundation

@objcMembers public class InternationalAutocompleteLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain the result
    //    of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/international-address-autocomplete-api#pro-http-request-input-fields"
    
    static let SSMaxResults = 10
    static let SSDistance = 5
    
    public var result:InternationalAutocompleteResult?
    public var country:String?
    public var search:String?
    public var maxResults:Int?
    public var distance:Int?
    public var geolocation:InternationalGeolocateType?
    public var administrativeArea:String?
    public var locality:String?
    public var postalCode:String?
    public var latitude:Double?
    public var longitude:Double?
    
    public enum InternationalGeolocateType: String, Codable {
        case adminarea
        case locality
        case postalcode
        case geocodes
        case none
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case search = "search"
        case maxResults = "max_results"
        case distance = "distance"
        case geolocation = "geolocation"
        case administrativeArea = "include_only_administrative_area"
        case locality = "include_only_locality"
        case postalCode = "include_only_postal_code"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    override public init() {
        self.maxResults = InternationalAutocompleteLookup.SSMaxResults
        self.distance = InternationalAutocompleteLookup.SSDistance
    }
    
    public func withSearch(search:String) -> InternationalAutocompleteLookup {
        self.search = search
        return self
    }
    
    func getResultAtIndex(index:Int) -> InternationalAutocompleteCandidate{
        if let result = self.result {
            return result.candidates![index]
        } else {
            return InternationalAutocompleteCandidate(dictionary: NSDictionary())
        }
    }
    
    public func setMaxResults(maxResults: Int, error: inout NSError?) {
        if maxResults > 0 && maxResults <= 10 {
            self.maxResults = maxResults
        } else {
            let details = [NSLocalizedDescriptionKey:"Max suggestions must be a postive integer no larger than 10."]
            error = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.NotPositiveIntergerError.rawValue, userInfo: details)
        }
    }
}
