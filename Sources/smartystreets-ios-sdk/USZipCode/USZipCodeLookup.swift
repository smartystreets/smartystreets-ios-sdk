import Foundation

@objcMembers public class USZipCodeLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also
    //    will contain the result of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/us-zipcode-api#http-request-input-fields"
    
    var result:USZipCodeResult!
    public var inputId:String?
    public var city:String?
    public var state:String?
    public var zipcode:String?
    
    override public init() {    }
    
    public init(city:String?, state:String?, zipcode:String?, inputId:String?) {
        if let city = city {
            self.city = city
        } else {
            self.city = nil
        }
        if let state = state {
            self.state = state
        } else {
            self.state = nil
        }
        if let zipcode = zipcode {
            self.zipcode = zipcode
        } else {
            self.zipcode = nil
        }
        if let inputId = inputId {
            self.inputId = inputId
        } else {
            self.inputId = nil
        }
    }
    
    public func toDictionary() -> NSDictionary {
        var dictionary = NSDictionary()
        
        dictionary = addValueToDictionary(value: self.city, key: "city", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.state, key: "state", dictionary: dictionary)
        dictionary = addValueToDictionary(value: self.zipcode, key: "zipcode", dictionary: dictionary)
        
        return dictionary
    }
    
    func addValueToDictionary(value:String?, key:String, dictionary:NSDictionary) -> NSDictionary {
        if let value = value {
            dictionary.setValue(value, forKey: key)
        }
        return dictionary
    }
}
