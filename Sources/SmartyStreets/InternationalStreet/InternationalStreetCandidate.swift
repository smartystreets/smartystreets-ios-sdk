import Foundation

@objcMembers public class InternationalStreetCandidate: NSObject, Codable {
    //    A candidate is a possible match for an address that was submitted. A lookup can have multiple
    //    candidates if the address was ambiguous.
    //
    //    See "https://smartystreets.com/docs/cloud/international-street-api#root"
    
    public var organization:String?
    public var address1:String?
    public var address2:String?
    public var address3:String?
    public var address4:String?
    public var address5:String?
    public var address6:String?
    public var address7:String?
    public var address8:String?
    public var address9:String?
    public var address10:String?
    public var address11:String?
    public var address12:String?
    public var components:InternationalStreetComponents?
    public var metadata:InternationalStreetMetadata?
    public var analysis:InternationalStreetAnalysis?
    
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
        if let components = dictionary["components"] {
            self.components = InternationalStreetComponents(dictionary: components as! NSDictionary)
        } else {
            self.components = InternationalStreetComponents(dictionary: NSDictionary())
        }
        if let metadata = dictionary["metadata"] {
            self.metadata = InternationalStreetMetadata(dictionary: metadata as! NSDictionary)
        } else {
            self.metadata = InternationalStreetMetadata(dictionary: NSDictionary())
        }
        if let analysis = dictionary["analysis"] {
            self.analysis = InternationalStreetAnalysis(dictionary: analysis as! NSDictionary)
        } else {
            self.analysis = InternationalStreetAnalysis(dictionary: NSDictionary())
        }
    }
}
