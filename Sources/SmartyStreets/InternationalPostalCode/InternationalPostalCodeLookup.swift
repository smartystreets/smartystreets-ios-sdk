import Foundation

@objcMembers public class InternationalPostalCodeLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain the
    //    result of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/international-postal-code-api"
    
    private var customParamArray: [String: String] = [:]
    public var result: [InternationalPostalCodeCandidate]?
    public var inputID: String?
    public var country: String?
    public var locality: String?
    public var administrativeArea: String?
    public var postalCode: String?
    
    enum CodingKeys: String, CodingKey {
        case inputID = "input_id"
        case country = "country"
        case locality = "locality"
        case administrativeArea = "administrative_area"
        case postalCode = "postal_code"
    }
    
    override public init() {}
    
    public func getResultAtIndex(index: Int) -> InternationalPostalCodeCandidate {
        if let results = self.result {
            return results[index]
        } else {
            return InternationalPostalCodeCandidate(dictionary: NSDictionary())
        }
    }
    
    public func getCustomParamArray() -> [String: String] {
        return self.customParamArray
    }
    
    public func addCustomParameter(parameter: String, value: String) {
        self.customParamArray.updateValue(value, forKey: parameter)
    }
}

