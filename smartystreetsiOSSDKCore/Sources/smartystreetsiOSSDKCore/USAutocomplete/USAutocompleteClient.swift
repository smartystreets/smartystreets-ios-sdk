import Foundation

public class USAutocompleteClient: NSObject {
    //    It is recommended to instantiate this class using SSClientBuilder
    
    var sender:SmartySender
    var serializer:SmartySerializer
    
    public init(sender:Any, serializer:SmartySerializer) {
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<USAutocompleteLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Lookup object to the US Autocomplete API and stores the result in the Lookup's result field.
        
        if let prefix = lookup.pointee.prefix {
            if prefix.count == 0 {
                let details = [NSLocalizedDescriptionKey:"sendLookup must be passed a Lookup with the prefix field set."]
                error.pointee = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.FieldNotSetError.rawValue, userInfo: details)
                return false
            }
            
            let request = buildRequest(lookup:lookup.pointee)
            let response = self.sender.sendRequest(request: request, error: &error.pointee)
            if error.pointee != nil { return false }
            
            let result:USAutocompleteResult = self.serializer.Deserialize(payload: response?.payload, error: &error.pointee) as! USAutocompleteResult
            
            // Naming of parameters to allow JSON deserialization
            if error.pointee != nil { return false }
            
            lookup.pointee.result = result
            return true
        } else {
            return false
        }
    }
    
    func buildRequest(lookup:USAutocompleteLookup) -> SmartyRequest {
        let request = SmartyRequest()
        
        request.setValue(value: lookup.prefix ?? "", HTTPParameterField: "prefix")
        request.setValue(value: lookup.getMaxSuggestionsStringIfSet(), HTTPParameterField: "suggestions")
        request.setValue(value: buildFilterString(list: lookup.cityFilter ?? [String]()), HTTPParameterField: "city_filter")
        request.setValue(value: buildFilterString(list: lookup.stateFilter ?? [String]()), HTTPParameterField: "state_filter")
        request.setValue(value: buildFilterString(list: lookup.prefer ?? [String]()), HTTPParameterField: "prefer")
        request.setValue(value: lookup.getPreferRatioStringIfSet(), HTTPParameterField: "prefer_ratio")
        
        if lookup.geolocateType!.name != "none" {
            request.setValue(value: "true", HTTPParameterField: "geolocate")
            request.setValue(value: lookup.geolocateType!.name, HTTPParameterField: "geolocate_precision")
        } else {
            request.setValue(value: "false", HTTPParameterField: "geolocate")
        }
        
        return request
    }
    
    func buildFilterString(list:[String]) -> String {
        if list.count == 0 {
            return String()
        }
        
        return list.joined(separator: ",")
    }
}
