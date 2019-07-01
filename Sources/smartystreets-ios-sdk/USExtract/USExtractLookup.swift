import Foundation

@objcMembers class USExtractLookup: NSObject, Codable {
    //    In addition to holding all of the input data for this lookup, this class also will contain the result
    //    of the lookup after it comes back from the API.
    //
    //    See "https://smartystreets.com/docs/cloud/us-extract-api#http-request-input-fields"
    
    var result:USExtractResult?
    var html:Bool?
    var aggressive:Bool?
    var addressesHaveLineBreaks:Bool?
    var addressesPerLine:Int?
    var text:String?
    
    override init() {
        self.aggressive = false
        self.addressesHaveLineBreaks = true
        self.addressesPerLine = 0
    }
    
    func withText(text: String) -> USExtractLookup {
        self.text = text
        return self
    }
    
    func specifyHtmlInput(html: Bool) {
        self.html = html
    }
    
    func setAggressive(aggressive: Bool) {
        self.aggressive = aggressive
    }
    
    func isHtml() -> Bool {
        if let html = self.html {
            return html
        } else {
            return false
        }
    }
    
    func isAggressive() -> Bool {
        if let aggressive = self.aggressive {
            return aggressive
        } else {
            return false
        }
    }
}
