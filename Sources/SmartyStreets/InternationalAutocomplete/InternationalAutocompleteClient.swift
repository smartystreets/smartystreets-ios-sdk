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
        
        if lookup.pointee.country == nil || (lookup.pointee.search == nil && lookup.pointee.addressID == nil) {
            let details = [NSLocalizedDescriptionKey:"sendLookup must be passed a Lookup with the country field set, and either search or addressID set."]
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
    }
    
    func buildRequest(lookup:InternationalAutocompleteLookup) -> SmartyRequest {
        let request = SmartyRequest()

        if let unwrappedPrefix = lookup.addressID {
            request.urlPrefix = "/" + unwrappedPrefix
        }
        
        request.setValue(value: lookup.search ?? "", HTTPParameterField: "search")
        request.setValue(value: lookup.country ?? "", HTTPParameterField: "country")
        request.setValue(value: lookup.maxResults.flatMap { String($0) } ?? "10", HTTPParameterField: "max_results")
        request.setValue(value: lookup.locality ?? "", HTTPParameterField: "include_only_locality")
        request.setValue(value: lookup.postalCode ?? "", HTTPParameterField: "include_only_postal_code")
        
        return request
    }
}
