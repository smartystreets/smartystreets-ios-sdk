import Foundation

@objcMembers public class USReverseGeoResult: NSObject, Codable {
    public var coordinate:USReverseGeoCoordinate?
    public var distance:Double?
    public var address:USReverseGeoAddress?
    
    init(dictionary: NSDictionary) {
        if let coordinate = dictionary["coordinate"] {
            self.coordinate = USReverseGeoCoordinate(dictionary: coordinate as! NSDictionary)
        } else {
            self.coordinate = USReverseGeoCoordinate(dictionary: NSDictionary())
        }
        
        self.distance = dictionary["distance"] as? Double
        
        if let address = dictionary["address"] {
            self.address = USReverseGeoAddress(dictionary: address as! NSDictionary)
        } else {
            self.address = USReverseGeoAddress(dictionary: NSDictionary())
        }
    }
}
