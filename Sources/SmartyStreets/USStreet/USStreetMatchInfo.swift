import Foundation

@objcMembers public class USStreetMatchInfo: NSObject, Codable {
    public var status: String?
    public var changes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case changes = "changes"
    }
    
    init(dictionary: NSDictionary) {
        self.status = dictionary["status"] as? String
        self.changes = dictionary["changes"] as? [String]
    }
}