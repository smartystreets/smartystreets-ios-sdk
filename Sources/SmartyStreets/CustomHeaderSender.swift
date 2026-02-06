import Foundation

public class CustomHeaderSender: SmartySender {

    var headers:[String:[String]]
    var appendHeaders:[String:String]
    var inner:SmartySender

    public init(headers:[String:[String]], appendHeaders:[String:String], inner:Any) {
        self.headers = headers
        self.appendHeaders = appendHeaders
        self.inner = inner as! SmartySender
    }

    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        for (key, values) in self.headers {
            let separator = self.appendHeaders[key] ?? ", "
            request.headers[key] = values.joined(separator: separator)
        }
        return self.inner.sendRequest(request: request, error: &error)
    }
}
