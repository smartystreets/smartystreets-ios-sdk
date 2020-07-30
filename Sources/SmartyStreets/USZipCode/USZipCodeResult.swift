import Foundation

@objcMembers public class USZipCodeResult: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-zipcode-api#root"
    
    public var status:String?
    public var reason:String?
    public var inputIndex:Int?
    public var objcInputIndex:NSNumber? {
        return inputIndex as NSNumber?
    }
    public var cities:[USCity]?
    public var zipCodes:[USZipCode]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case reason = "reason"
        case inputIndex = "input_index"
        case cities = "city_states"
        case zipCodes = "zipcodes"
    }
    
    public init(dictionary:NSDictionary) {
        super.init()
        self.status = dictionary["status"] as? String
        self.reason = dictionary["reason"] as? String
        self.inputIndex = dictionary["input_index"] as? Int
        if let cityStates = dictionary["city_states"] {
            self.cities = convertToCityObjects((cityStates as! [[String:Any]]))
        } else {
            self.cities = [USCity]()
        }
        if let zipCodes = dictionary["zipcodes"] {
            self.zipCodes = convertToZipCodeObjects(zipCodes as! [[String:Any]])
        } else {
            self.zipCodes = [USZipCode]()
        }
    }
    
    func isValid() -> Bool {
        return self.status == nil && self.reason == nil
    }
    
    func convertToCityObjects(_ object:[[String:Any]]) -> [USCity] {
        var mutable = [USCity]()
        for city in object {
            mutable.append(USCity(dictionary: city as NSDictionary))
        }
        return mutable
    }
    
    func convertToZipCodeObjects(_ object:[[String:Any]]) -> [USZipCode] {
        var mutable = [USZipCode]()
        for zip in object {
            mutable.append(USZipCode(dictionary: zip as NSDictionary))
        }
        return mutable
    }
}
