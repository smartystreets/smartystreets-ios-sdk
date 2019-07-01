import Foundation

@objcMembers class USStreetAnalysis: NSObject, Codable {
    //    See "https://smartystreets.com/docs/cloud/us-street-api#analysis"
    
    var dpvMatchCode:String?
    var dpvFootnotes:String?
    var cmra:String?
    var vacant:String?
    var active:String?
    var footnotes:String?
    var lacsLinkCode:String?
    var lacsLinkIndicator:String?
    var isSuiteLinkMatch:Bool?
    public var objcIsSuiteLinkMatch:NSNumber? {
        get {
            return isSuiteLinkMatch as NSNumber?
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case dpvMatchCode = "dpv_match_code"
        case dpvFootnotes = "dpv_footnotes"
        case cmra = "dpv_cmra"
        case vacant = "dpv_vacant"
        case active = "active"
        case footnotes = "footnotes"
        case lacsLinkCode = "lacslink_code"
        case lacsLinkIndicator = "lacslink_indicator"
        case isSuiteLinkMatch = "suitelink_match"
    }
    
    init(dictionary: NSDictionary) {
        self.dpvMatchCode = dictionary["dpv_match_code"] as? String
        self.dpvFootnotes = dictionary["dpv_footnotes"] as? String
        self.cmra = dictionary["dpv_cmra"] as? String
        self.vacant = dictionary["dpv_vacant"] as? String
        self.active = dictionary["active"] as? String
        self.footnotes = dictionary["footnotes"] as? String
        self.lacsLinkCode = dictionary["lacslink_code"] as? String
        self.lacsLinkIndicator = dictionary["lacslink_indicator"] as? String
        self.isSuiteLinkMatch = dictionary["suitelink_match"] as? Bool
    }
}
