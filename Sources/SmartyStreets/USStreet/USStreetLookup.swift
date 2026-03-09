import Foundation

@objcMembers public class USStreetLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain
    //    the result of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/us-street-api#input-fields"
    //
    //    match: Must be set to 'strict', 'enhanced', or 'invalid'.
    
    private var customParamArray: [String: String] = [:]
    public var result:[USStreetCandidate]!
    public var inputId:String?
    public var street:String?
    public var street2:String?
    public var secondary:String?
    public var city:String?
    public var state:String?
    public var zipCode:String?
    public var lastline:String?
    public var addressee:String?
    public var urbanization:String?
    public var maxCandidates:Int = 0
    public var countySource:String?
    public var objcMaxCandidates:NSNumber {
        get {
            return maxCandidates as NSNumber
        }
    }
    public var matchStrategy:String?
    public var outputFormat:String?
    
    override public init() {
        self.result = [USStreetCandidate]()
    }

    public init(freeformAddress:String) {
        self.result = [USStreetCandidate]()
        self.street = freeformAddress
    }
    
    public func addToResult(newCandidate:USStreetCandidate) {
        self.result.append(newCandidate)
    }
    
    public func getResultAtIndex(index:Int) -> USStreetCandidate {
        return self.result[index]
    }
    
    public func getCustomParamArray() -> [String: String] {
        return self.customParamArray
    }
    
    public func addCustomParameter(parameter: String, value: String) {
        self.customParamArray.updateValue(value, forKey: parameter)
    }
    
    public func setMaxCandidates(max:Int, error: inout NSError?) {
        if max > 0 {
            self.maxCandidates = max
        } else {
            let details = [NSLocalizedDescriptionKey:"Max candidates must be a positive integer."]
            error = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.NotPositiveIntergerError.rawValue, userInfo: details)
        }
    }

    enum CodingKeys: String, CodingKey {
        case street, street2, secondary, city, state
        case zipCode = "zipcode"
        case lastline, addressee, urbanization
        case inputId = "input_id"
        case maxCandidates = "candidates"
        case matchStrategy = "match"
        case outputFormat = "format"
        case countySource = "county_source"
    }

    struct DynamicCodingKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(inputId, forKey: .inputId)
        try container.encodeIfPresent(street, forKey: .street)
        try container.encodeIfPresent(street2, forKey: .street2)
        try container.encodeIfPresent(secondary, forKey: .secondary)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(zipCode, forKey: .zipCode)
        try container.encodeIfPresent(lastline, forKey: .lastline)
        try container.encodeIfPresent(addressee, forKey: .addressee)
        try container.encodeIfPresent(urbanization, forKey: .urbanization)
        try container.encodeIfPresent(outputFormat, forKey: .outputFormat)
        try container.encodeIfPresent(countySource, forKey: .countySource)

        let effectiveMatch = matchStrategy ?? "enhanced"
        try container.encode(effectiveMatch, forKey: .matchStrategy)

        if maxCandidates > 0 {
            try container.encode(maxCandidates, forKey: .maxCandidates)
        } else if effectiveMatch == "enhanced" {
            try container.encode(5, forKey: .maxCandidates)
        }

        // Custom parameters as top-level keys
        var dynamicContainer = encoder.container(keyedBy: DynamicCodingKey.self)
        for (key, value) in customParamArray {
            if let codingKey = DynamicCodingKey(stringValue: key) {
                try dynamicContainer.encode(value, forKey: codingKey)
            }
        }
    }
}
