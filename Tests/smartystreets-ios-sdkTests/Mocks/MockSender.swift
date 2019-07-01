import Foundation
@testable import smartystreets_ios_sdk

class MockSender: SmartySender {
    
    var response:SmartyResponse!
    var request:SmartyRequest!
    
    init(response:SmartyResponse!) {
        self.response = response
        self.request = nil
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.request = request
        return self.response
    }
}
