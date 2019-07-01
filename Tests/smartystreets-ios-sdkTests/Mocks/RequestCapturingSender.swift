import Foundation
@testable import smartystreets_ios_sdk

class RequestCapturingSender:SmartySender {
    
    var request:SmartyRequest!
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.request = request
        self.request.urlPrefix = "http://localhost/?"
        
        let emptyString = "[]"
        let data = emptyString.data(using: String.Encoding.utf8)
        
        return SmartyResponse(statusCode: 200, payload: data!)
    }
}
