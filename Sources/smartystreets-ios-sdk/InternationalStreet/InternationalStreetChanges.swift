import Foundation

@objcMembers class InternationalStreetChanges: InternationalStreetRootLevel {
    
    var components:InternationalStreetComponents?
    
    override init(dictionary: NSDictionary) {
        super.init(dictionary: dictionary)
        if let components = dictionary["components"] {
            self.components = InternationalStreetComponents(dictionary: components as! NSDictionary)
        } else {
            self.components = InternationalStreetComponents(dictionary: NSDictionary())
        }
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
