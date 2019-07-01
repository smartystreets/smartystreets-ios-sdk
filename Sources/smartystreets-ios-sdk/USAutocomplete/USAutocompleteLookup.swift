import Foundation

@objcMembers public class USAutocompleteLookup: NSObject, Codable {
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
    
    let SSMaxSuggestions = 10
    let SSPreferRatio = 1.0 / 3.0
    
    var result:USAutocompleteResult?
    public var prefix:String?
    var maxSuggestions:Int?
    var cityFilter:[String]?
    var stateFilter:[String]?
    var prefer:[String]?
    public var geolocateType:GeolocateType?
    public var preferRatio:Double?
    
    enum CodingKeys: String, CodingKey {
        case maxSuggestions = "max_suggestions"
        case cityFilter = "city_filter"
        case stateFilter = "state_filter"
        case geolocateType = "geolocate_type"
        case preferRatio = "prefer_ratio"
    }
    
    override public init() {
        self.maxSuggestions = SSMaxSuggestions
        self.cityFilter = [String]()
        self.stateFilter = [String]()
        self.prefer = [String]()
        self.geolocateType = GeolocateType(name:"city")
        self.preferRatio = SSPreferRatio
    }
    
    public func withPrefix(prefix:String) -> USAutocompleteLookup {
        self.prefix = prefix
        return self
    }
    
    func getResultAtIndex(index:Int) -> USAutocompleteSuggestion{
        if let result = self.result {
            return result.suggestions![index]
        } else {
            return USAutocompleteSuggestion(dictionary: NSDictionary())
        }
    }
    
    func getMaxSuggestionsStringIfSet() -> String {
        if self.maxSuggestions == SSMaxSuggestions {
            return String()
        } else {
            return "\(self.maxSuggestions ?? 0)"
        }
    }
    
    func getPreferRatioStringIfSet() -> String {
        if self.preferRatio == SSPreferRatio {
            return String()
        } else {
            return "\(self.preferRatio ?? 0)"
        }
    }
    
    public func setMaxSuggestions(maxSuggestions: Int, error: inout NSError?) {
        if maxSuggestions > 0 && maxSuggestions <= 10 {
            self.maxSuggestions = maxSuggestions
        } else {
            let details = [NSLocalizedDescriptionKey:"Max suggestions must be a postive integer no larger than 10."]
            error = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.NotPositiveIntergerError.rawValue, userInfo: details)
        }
    }
    
    public func addCityFilter(city:String) {
        self.cityFilter?.append(city)
    }
    
    public func addStateFilter(state:String) {
        self.stateFilter?.append(state)
    }
    
    public func addPrefer(cityORstate:String) {
        self.prefer?.append(cityORstate)
    }
}
