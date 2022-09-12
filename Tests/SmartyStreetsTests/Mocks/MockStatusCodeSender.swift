import Foundation
@testable import SmartyStreets

class MockStatusCodeSender: StatusCodeSender {
    
    var statusCode:Int
    var payload:Data
    
    init(statusCode:Int) {
        self.statusCode = statusCode
        self.payload = Data()
        super.init(inner: SmartySender())
    }
    
    init(statusCode:Int, payload: String) {
        self.statusCode = statusCode
        self.payload = payload.data(using: .utf8)!
        super.init(inner: SmartySender())
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        if self.statusCode == 0 {
            return nil
        }
        
        return SmartyResponse(statusCode: self.statusCode, payload: self.payload)
    }
}
