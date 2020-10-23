import Foundation

@objcMembers public class USReverseGeoCoordinate: NSObject, Codable {
    public var latitude:Double?
    public var longitude:Double?
    public var accuracy:String?
    public var license:Int?
    
    init(dictionary: NSDictionary) {
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.accuracy = dictionary["accuracy"] as? String
        self.license = dictionary["license"] as? Int
    }
}
