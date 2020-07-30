import Foundation

@objcMembers public class InternationalStreetCandidate: InternationalStreetRootLevel {
    //    A candidate is a possible match for an address that was submitted. A lookup can have multiple
    //    candidates if the address was ambiguous.
    //
    //    See "https://smartystreets.com/docs/cloud/international-street-api#root"
    
    public var components:InternationalStreetComponents?
    public var metadata:InternationalStreetMetadata?
    public var analysis:InternationalStreetAnalysis?
    
    override init(dictionary: NSDictionary) {
        super.init(dictionary: dictionary)
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
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
