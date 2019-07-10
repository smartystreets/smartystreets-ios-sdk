import Foundation

@objcMembers public class USExtractLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain the result
    //    of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields"
    
    public var result:USExtractResult?
    public var html:Bool?
    public var aggressive:Bool?
    public var addressesHaveLineBreaks:Bool?
    public var addressesPerLine:Int?
    public var text:String?
    
    override public init() {
        self.aggressive = false
        self.addressesHaveLineBreaks = true
        self.addressesPerLine = 0
    }
    
    public func withText(text: String) -> USExtractLookup {
        self.text = text
        return self
    }
    
    public func specifyHtmlInput(html: Bool) {
        self.html = html
    }
    
    public func setAggressive(aggressive: Bool) {
        self.aggressive = aggressive
    }
    
    public func isHtml() -> Bool {
        if let html = self.html {
            return html
        } else {
            return false
        }
    }
    
    public func isAggressive() -> Bool {
        if let aggressive = self.aggressive {
            return aggressive
        } else {
            return false
        }
    }
}
