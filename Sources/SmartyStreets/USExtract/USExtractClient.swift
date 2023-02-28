import Foundation

@objcMembers public class USExtractClient: NSObject {
    //    It is recommended to instantiate this class using SSClientBuilder
    
    var sender:SmartySender
    var serializer:SmartySerializer
    
    init(sender:Any, serializer:SmartySerializer) {
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<USExtractLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Lookup object to the US Extract Code API and stores the result in the Lookup's result field.
        //        It also returns the result directly.
        
        if let text = lookup.pointee.text {
            if text.count == 0 {
                let details = [NSLocalizedDescriptionKey:"sendLookup requires a Lookup with the 'text' field set"]
                error.pointee = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.FieldNotSetError.rawValue, userInfo: details)
                return false
            }
            
            let request = buildRequest(lookup: lookup.pointee)
            let response = self.sender.sendRequest(request: request, error: &error.pointee)
            if error.pointee != nil { return false }
            
            let result = self.serializer.Deserialize(payload: response?.payload, error: &error.pointee) as! NSDictionary
            
            if error.pointee != nil { return false }
            
            lookup.pointee.result = USExtractResult(dictionary: result)
            
            return true
        }
        return false
    }
    
    func buildRequest(lookup:USExtractLookup) -> SmartyRequest {
        let request = SmartyRequest()
        request.method = "POST"
        request.contentType = "text/plain"
        let payload = lookup.text?.data(using: .utf8)
        request.payload = payload
        
        request.setValue(value: String(lookup.isHtml()), HTTPParameterField: "html")
        request.setValue(value: String(lookup.isAggressive()), HTTPParameterField: "aggressive")
        request.setValue(value: "\(lookup.addressesHaveLineBreaks ?? false)", HTTPParameterField: "addr_line_breaks")
        request.setValue(value: "\(lookup.addressesPerLine ?? 0)", HTTPParameterField: "addr_per_line")
        if lookup.match != USExtractLookup.MatchStrategy.strict {
            request.setValue(value: lookup.match?.rawValue ?? "", HTTPParameterField: "match")
        }
        return request
    }
}
