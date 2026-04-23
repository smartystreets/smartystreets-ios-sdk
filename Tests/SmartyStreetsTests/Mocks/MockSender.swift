import Foundation
@testable import SmartyStreets

class MockSender: SmartySender {
    
    var response:SmartyResponse!
    var request:SmartyRequest!
    
    override init() {    }
    
    init(response:SmartyResponse!) {
        self.response = response
        self.request = nil
    }

    init(statusCode:Int, payload:Data, headers:[String:String]) {
        self.response = SmartyResponse(statusCode: statusCode, payload: payload, headers: headers)
        self.request = nil
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.request = request
        return self.response
    }
}
