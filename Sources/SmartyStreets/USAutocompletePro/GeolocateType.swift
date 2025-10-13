import Foundation

@objcMembers public class GeolocateType: NSObject, Codable {
    
    var SSGeolocateTypeCity = "city"
    var SSGeolocateTypeState = "state"
    var SSGeolocateTypeNone = "null"
    
    var name:String
    
    public init(name:String) {
        self.name = name
    }
}
