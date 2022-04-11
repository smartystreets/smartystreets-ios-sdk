import Foundation

@objcMembers public class USStreetCandidate: NSObject, Codable {
    //    A candidate is a possible match for an address that was submitted.
    //    A lookup can have multiple candidates if the address was ambiguous, and
    //    the maxCandidates field is set higher than 1.
    //
    //    See "https://smartystreets.com/docs/cloud/us-street-api#root"
    
    public var status:String?
    public var reason:String?
    public var inputId:String?
    public var inputIndex:Int?
    public var objcInputIndex:NSNumber? {
        get {
            return inputIndex as NSNumber?
        }
    }
    public var candidateIndex:Int?
    public var objcCandidateIndex:NSNumber? {
        get {
            return candidateIndex as NSNumber?
        }
    }
    public var addressee:String?
    public var deliveryLine1:String?
    public var deliveryLine2:String?
    public var lastline:String?
    public var deliveryPointBarcode:String?
    public var components:USStreetComponents?
    public var metadata:USStreetMetadata?
    public var analysis:USStreetAnalysis?
    
    enum CodingKeys:String, CodingKey {
        case inputId = "input_id"
        case inputIndex = "input_index"
        case candidateIndex = "candidate_index"
        case addressee = "addressee"
        case deliveryLine1 = "delivery_line_1"
        case deliveryLine2 = "delivery_line_2"
        case lastline = "last_line"
        case deliveryPointBarcode = "delivery_point_barcode"
        case components = "components"
        case metadata = "metadata"
        case analysis = "analysis"
    }
    
    init(dictionary:NSDictionary) {
        self.inputId = dictionary["input_id"] as? String
        self.inputIndex = dictionary["input_index"] as? Int
        self.candidateIndex = dictionary["candidate_index"] as? Int
        self.addressee = dictionary["addressee"] as? String
        self.deliveryLine1 = dictionary["delivery_line_1"] as? String
        self.deliveryLine2 = dictionary["delivery_line_2"] as? String
        self.lastline = dictionary["last_line"] as? String
        self.deliveryPointBarcode = dictionary["delivery_point_barcode"] as? String
        if let components = dictionary["components"] {
            self.components = USStreetComponents(dictionary: components as! NSDictionary)
        } else {
            self.components = USStreetComponents(dictionary: NSDictionary())
        }
        if let metadata = dictionary["metadata"] {
            self.metadata = USStreetMetadata(dictionary: metadata as! NSDictionary)
        } else {
            self.metadata = USStreetMetadata(dictionary: NSDictionary())
        }
        if let analysis = dictionary["analysis"]{
            self.analysis = USStreetAnalysis(dictionary: analysis as! NSDictionary)
        } else {
            self.analysis = USStreetAnalysis(dictionary: NSDictionary())
        }
    }
    
    init(inputIndex:Int) {
        self.inputIndex = inputIndex
    }
}
