import Foundation

@objcMembers class InternationalStreetRootLevel: NSObject, Codable {
    
    var organization:String?
    var address1:String?
    var address2:String?
    var address3:String?
    var address4:String?
    var address5:String?
    var address6:String?
    var address7:String?
    var address8:String?
    var address9:String?
    var address10:String?
    var address11:String?
    var address12:String?
    
    init(dictionary: NSDictionary) {
        self.organization = dictionary["organization"] as? String
        self.address1 = dictionary["address1"] as? String
        self.address2 = dictionary["address2"] as? String
        self.address3 = dictionary["address3"] as? String
        self.address4 = dictionary["address4"] as? String
        self.address5 = dictionary["address5"] as? String
        self.address6 = dictionary["address6"] as? String
        self.address7 = dictionary["address7"] as? String
        self.address8 = dictionary["address8"] as? String
        self.address9 = dictionary["address9"] as? String
        self.address10 = dictionary["address10"] as? String
        self.address11 = dictionary["address11"] as? String
        self.address12 = dictionary["address12"] as? String
    }
    
}
