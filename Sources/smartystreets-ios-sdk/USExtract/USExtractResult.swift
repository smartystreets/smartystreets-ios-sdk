import Foundation

@objcMembers class USExtractResult: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-extract-api#http-response-status"
    
    var metadata:USExtractMetadata?
    var addresses:[USExtractAddress]?
    
    init(dictionary: NSDictionary) {
        super.init()
        if let metadata = dictionary["meta"] {
            self.metadata = USExtractMetadata(dictionary: metadata as! NSDictionary)
        } else {
            self.metadata = USExtractMetadata(dictionary: NSDictionary())
        }
        if let addresses = dictionary["addresses"] {
            self.addresses = convertToAddressObjects(addresses as! [[String:Any]])
        } else {
            self.addresses = [USExtractAddress]()
        }
    }
    
    func convertToAddressObjects(_ object:[[String:Any]]) -> [USExtractAddress] {
        var mutable = [USExtractAddress]()
        for city in object {
            mutable.append(USExtractAddress(dictionary: city as NSDictionary))
        }
        return mutable
    }
    
    func getAddressAtIndex(index:Int) -> USExtractAddress {
        if let addresses = self.addresses {
            return addresses[index]
        } else {
            return USExtractAddress(dictionary: NSDictionary())
        }
    }
}
