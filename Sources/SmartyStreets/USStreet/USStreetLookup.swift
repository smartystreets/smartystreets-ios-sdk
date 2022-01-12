import Foundation

@objcMembers public class USStreetLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain
    //    the result of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/us-street-api#input-fields"
    //
    //    match: Must be set to 'strict', 'range', or 'invalid'.
    
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
    public var maxCandidates:Int?
    public var objcMaxCandidates:NSNumber? {
        get {
            return maxCandidates as NSNumber?
        }
    }
    public var matchStrategy:String?
    
    override public init() {
        self.maxCandidates = 1
        self.result = [USStreetCandidate]()
    }
    
    public init(freeformAddress:String) {
        self.maxCandidates = 1
        self.result = [USStreetCandidate]()
        self.street = freeformAddress
    }
    
    public func addToResult(newCandidate:USStreetCandidate) {
        self.result.append(newCandidate)
    }
    
    public func getResultAtIndex(index:Int) -> USStreetCandidate {
        return self.result[index]
    }
    
    public func setMaxCandidates(max:Int, error: inout NSError?) {
        if max > 0 {
            self.maxCandidates = max
        } else {
            let details = [NSLocalizedDescriptionKey:"Max candidates must be a positive integer."]
            error = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.NotPositiveIntergerError.rawValue, userInfo: details)
        }
    }
    
    func toDictionary() -> NSDictionary {
        var dictionary = NSDictionary()
        
        dictionary = addValueToDictionary(value: self.inputId, key: "input_id", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.street, key: "street", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.street2, key: "street2", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.secondary, key: "secondary", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.city, key: "city", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.state, key: "state", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.zipCode, key: "zipcode", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.lastline, key: "lastline", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.addressee, key: "addressee", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.urbanization, key: "urbanization", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.maxCandidates, key: "candidates", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.matchStrategy, key: "match", dictionary: dictionary)
        
        return dictionary
    }
    
    func addValueToDictionary(value:Any?, key:String, dictionary:NSDictionary) -> NSDictionary {
        if let value = value {
            dictionary.setValue(value, forKey: key)
        }
        return dictionary
    }
}
