import Foundation
@testable import smartystreets_ios_sdk

class MockStatusCodeSender: StatusCodeSender {
    
    var statusCode:Int
    
    init(statusCode:Int) {
        self.statusCode = statusCode
        super.init(inner: SmartySender())
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        if self.statusCode == 0 {
            return nil
        }
        
        return SmartyResponse(statusCode: self.statusCode, payload: Data())
    }
}
