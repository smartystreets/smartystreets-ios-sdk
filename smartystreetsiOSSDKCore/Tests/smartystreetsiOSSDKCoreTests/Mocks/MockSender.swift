import Foundation
@testable import smartystreetsiOSSDKCore

class MockSender: SmartySender {
    
    var response:SmartyResponse!
    var request:SmartyRequest!
    
    override init() {    }
    
    init(response:SmartyResponse!) {
        self.response = response
        self.request = nil
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.request = request
        return self.response
    }
}
