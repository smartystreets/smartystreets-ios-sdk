import Foundation

public class LicenseSender: SmartySender {
    
    var licenses:[String]?
    var inner:SmartySender
    
    public init(licenses:[String]?, inner:Any) {
        self.licenses = licenses
        self.inner = inner as! SmartySender
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        request.parameters["license"] = self.licenses?.joined(separator: ",")
        return self.inner.sendRequest(request: request, error: &error)
    }
}
