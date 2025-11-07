import Foundation

public class InternationalPostalCodeClient: NSObject {
    //    It is recommended to instantiate this class using SSClientBuilder
    
    var sender: SmartySender
    public var serializer: SmartySerializer
    
    public init(sender: Any, serializer: SmartySerializer) {
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<InternationalPostalCodeLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Lookup object to the International Postal Code API and stores the result in the Lookup's result field.
        
        let request = buildRequest(lookup: lookup.pointee)
        let response = self.sender.sendRequest(request: request, error: &error.pointee)
        if error.pointee != nil { return false }
        
        let candidates: [InternationalPostalCodeCandidate]! = serializer.Deserialize(payload: response?.payload, error: &error.pointee) as? [InternationalPostalCodeCandidate]
        if error.pointee != nil { return false }
        lookup.pointee.result = candidates
        
        return true
    }
    
    func buildRequest(lookup: InternationalPostalCodeLookup) -> SmartyRequest {
        let request = SmartyRequest()
        
        request.setValue(value: lookup.inputID ?? "", HTTPParameterField: "input_id")
        request.setValue(value: lookup.country ?? "", HTTPParameterField: "country")
        request.setValue(value: lookup.locality ?? "", HTTPParameterField: "locality")
        request.setValue(value: lookup.administrativeArea ?? "", HTTPParameterField: "administrative_area")
        request.setValue(value: lookup.postalCode ?? "", HTTPParameterField: "postal_code")
        
        for key in lookup.getCustomParamArray().keys {
            request.setValue(value: lookup.getCustomParamArray()[key] ?? "", HTTPParameterField: key)
        }
        
        return request
    }
}

