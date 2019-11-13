import Foundation

@objcMembers public class USAutocompleteProLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain the result
    //    of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/us-autocomplete-api#http-request-input-fields"
    //
    //    prefix: The beginning of an address (required)
    //    suggestions: Maximum number of suggestions
    //    cityFilter: List of cities from which to include suggestions
    //    stateFilter: List of states from which to include suggestions
    //    prefer: List of cities/states. Suggestions from the members of this list will appear first
    //    preferRatio: Percentage of suggestions that will be from preferred cities/states.
    //    (Decimal value between 0 and 1)
    //    geolocateType: This field corresponds to the geolocate and geolocate precision fields in the
    //    US Autocomplete API. Use the constants in GeolocateType to set this field
    
    let SSMaxResults = 10
    let SSPreferRatio = 1.0 / 3.0
    
    public var result:USAutocompleteProResult?
    public var search:String?
    public var selected:String?
    public var maxResults:Int?
    public var includeOnlyCities:[String]?
    public var includeOnlyStates:[String]?
    public var includeOnlyZIPCodes:[String]?
    public var excludeStates:[String]?
    public var preferCities:[String]?
    public var preferStates:[String]?
    public var preferZIPCodes:[String]?
    public var preferGeolocation:GeolocateType?
    public var preferRatio:Double?
    
    enum CodingKeys: String, CodingKey {
        case maxResults = "max_results"
        case includeOnlyCities = "include_only_cities"
        case includeOnlyStates = "include_only_states"
        case includeOnlyZIPCodes = "include_only_zipcodes"
        case excludeStates = "exclude_states"
        case preferCities = "prefer_cities"
        case preferStates = "prefer_states"
        case preferZIPCodes = "prefer_zipcodes"
        case preferGeolocation = "prefer_geolocation"
        case preferRatio = "prefer_ratio"
    }
    
    override public init() {
        self.maxResults = SSMaxResults
        self.includeOnlyCities = [String]()
        self.includeOnlyStates = [String]()
        self.includeOnlyZIPCodes = [String]()
        self.excludeStates = [String]()
        self.preferCities = [String]()
        self.preferStates = [String]()
        self.preferZIPCodes = [String]()
        self.preferGeolocation = GeolocateType(name:"city")
        self.preferRatio = SSPreferRatio
    }
    
    public func withSearch(search:String) -> USAutocompleteProLookup {
        self.search = search
        return self
    }
    
    func getResultAtIndex(index:Int) -> USAutocompleteProSuggestion{
        if let result = self.result {
            return result.suggestions![index]
        } else {
            return USAutocompleteProSuggestion(dictionary: NSDictionary())
        }
    }
    
    func getMaxResultsStringIfSet() -> String {
        if self.maxResults == SSMaxResults {
            return String()
        } else {
            return "\(self.maxResults ?? 0)"
        }
    }
    
    func getPreferRatioStringIfSet() -> String {
        if self.preferRatio == SSPreferRatio {
            return String()
        } else {
            return "\(self.preferRatio ?? 0)"
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
    
    public func addCityFilter(city:String) {
        self.includeOnlyCities?.append(city)
    }
    
    public func addStateFilter(state:String) {
        self.includeOnlyStates?.append(state)
    }
    
    public func addZIPCodeFilter(zipcode:String) {
        self.includeOnlyZIPCodes?.append(zipcode)
    }
    
    public func addPreferCity(city:String) {
        self.preferCities?.append(city)
    }
    
    public func addPreferState(state:String) {
        self.preferStates?.append(state)
    }
    
    public func addPreferZIPCode(zipcode:String) {
        self.preferZIPCodes?.append(zipcode)
    }
}
