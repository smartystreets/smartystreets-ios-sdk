import Foundation

public class InternationalAutocompleteClient: NSObject {
    //    It is recommended to instantiate this class using SSClientBuilder
    
    var sender:SmartySender
    public var serializer:SmartySerializer
    
    public init(sender:Any, serializer:SmartySerializer) {
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<InternationalAutocompleteLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Lookup object to the International Autocomplete API and stores the result in the Lookup's result field.
        
        if let prefix = lookup.pointee.search {
            if prefix.count == 0 {
                let details = [NSLocalizedDescriptionKey:"sendLookup must be passed a Lookup with the prefix field set."]
                error.pointee = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.FieldNotSetError.rawValue, userInfo: details)
                return false
            }
            
            let request = buildRequest(lookup:lookup.pointee)
            let response = self.sender.sendRequest(request: request, error: &error.pointee)
            if error.pointee != nil { return false }
            
            var result:InternationalAutocompleteResult
            
            if let payload = response?.payload {
                result = self.serializer.Deserialize(payload: payload, error: &error.pointee) as? InternationalAutocompleteResult ?? InternationalAutocompleteResult(dictionary: NSDictionary())
            } else {
                result = InternationalAutocompleteResult(dictionary: NSDictionary())
            }
            
            // Naming of parameters to allow JSON deserialization
            if error.pointee != nil { return false }
            
            lookup.pointee.result = result
            return true
        } else {
            return false
        }
    }
    
    func buildRequest(lookup:InternationalAutocompleteLookup) -> SmartyRequest {
        let request = SmartyRequest()
        
        request.setValue(value: lookup.search ?? "", HTTPParameterField: "search")
        request.setValue(value: lookup.country ?? "", HTTPParameterField: "country")
        request.setValue(value: lookup.getMaxResultsStringIfSet(), HTTPParameterField: "max_results")
        request.setValue(value: lookup.administrativeArea ?? "", HTTPParameterField: "include_only_administrative_area")
        request.setValue(value: lookup.locality ?? "", HTTPParameterField: "include_only_locality")
        request.setValue(value: lookup.postalCode ?? "", HTTPParameterField: "include_only_postal_code")
        
        return request
    }
}
