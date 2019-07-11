import Foundation

@objcMembers public class USExtractAddress: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-extract-api#http-response-status"
    
    public var text:String?
    public var verified:Bool?
    public var line:Int?
    public var start:Int?
    public var end:Int?
    public var candidates:[USStreetCandidate]?
    
    enum CodingKeys: String, CodingKey {
        case candidates = "api_output"
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        print(dictionary)
        self.text = dictionary["text"] as? String
        self.verified = dictionary["verified"] as? Bool
        self.line = dictionary["line"] as? Int
        self.start = dictionary["start"] as? Int
        self.end = dictionary["end"] as? Int
        if let candidates = dictionary["api_output"] {
            self.candidates = convertToCandidateObjects(candidates as! [[String:Any]])
        } else {
            self.candidates = [USStreetCandidate]()
        }
    }
    
    func convertToCandidateObjects(_ object:[[String:Any]]) -> [USStreetCandidate] {
        var mutable = [USStreetCandidate]()
        for city in object {
            mutable.append(USStreetCandidate(dictionary: city as NSDictionary))
        }
        return mutable
    }
    
    public func isVerified() -> Bool {
        if let verified = self.verified {
            return verified
        } else {
            return false
        }
    }
}
