import Foundation

public class CustomQuerySender: SmartySender {
    
    var queries:[String:String]
    var inner:SmartySender
    
    public init(queries:[String:String], inner:Any) {
        self.queries = queries
        self.inner = inner as! SmartySender
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        request.parameters.merge(queries) { _, new in new}
        return self.inner.sendRequest(request: request, error: &error)
    }
}
