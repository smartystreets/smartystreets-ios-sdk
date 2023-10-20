import Foundation
@testable import SmartyStreets

class RequestCapturingSender:SmartySender {
    
    var request:SmartyRequest!
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.request = request
        
        let emptyString = "[]"
        let data = emptyString.data(using: String.Encoding.utf8)
        
        return SmartyResponse(statusCode: 200, payload: data!)
    }
}
