import Foundation

public class CustomHeaderSender: SmartySender {

    var headers:[String:String]
    var inner:SmartySender

    public init(headers:[String:String], inner:Any) {
        self.headers = headers
        self.inner = inner as! SmartySender
    }

    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        for (key, value) in self.headers {
            request.headers[key] = value
        }
        return self.inner.sendRequest(request: request, error: &error)
    }
}
