import Foundation

@objcMembers public class USReverseGeoResponse: NSObject, Codable {
    public var results:[USReverseGeoResult]?
    
    public init(dictionary: NSDictionary) {
        if let result = dictionary["results"] {
            self.results?.append(USReverseGeoResult(dictionary: result as! NSDictionary))
        } else {
            self.results?.append(USReverseGeoResult(dictionary: NSDictionary()))
        }
    }
}
