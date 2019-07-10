import Foundation

@objcMembers public class GeolocateType: NSObject, Codable {
    
    let SSGeolocateTypeCity = "city"
    let SSGeolocateTypeState = "state"
    let SSGeolocateTypeNone = "null"
    
    var name:String
    
    public init(name:String) {
        self.name = name
    }
}
