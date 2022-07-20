import Foundation
@testable import SmartyStreets

class RequestCapturingDataSender:SmartySender {
    
    var request:SmartyRequest!
    var data:Data!
    
    init(dataToReturn:Data) {
        self.data = dataToReturn
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.request = request
        self.request.urlPrefix = "http://localhost/?"
        
        return SmartyResponse(statusCode: 200, payload: self.data)
    }
}

