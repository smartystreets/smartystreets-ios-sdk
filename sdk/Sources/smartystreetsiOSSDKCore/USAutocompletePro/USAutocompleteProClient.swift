import Foundation

public class USAutocompleteProClient: NSObject {
    //    It is recommended to instantiate this class using SSClientBuilder
    
    var sender:SmartySender
    var serializer:SmartySerializer
    
    public init(sender:Any, serializer:SmartySerializer) {
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<USAutocompleteProLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Lookup object to the US Autocomplete API and stores the result in the Lookup's result field.
        
        if let prefix = lookup.pointee.search {
            if prefix.count == 0 {
                let details = [NSLocalizedDescriptionKey:"sendLookup must be passed a Lookup with the prefix field set."]
                error.pointee = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.FieldNotSetError.rawValue, userInfo: details)
                return false
            }
            
            let request = buildRequest(lookup:lookup.pointee)
            let response = self.sender.sendRequest(request: request, error: &error.pointee)
            if error.pointee != nil { return false }
            
            let result:USAutocompleteProResult = self.serializer.Deserialize(payload: response?.payload, error: &error.pointee) as! USAutocompleteProResult
            
            // Naming of parameters to allow JSON deserialization
            if error.pointee != nil { return false }
            
            lookup.pointee.result = result
            return true
        } else {
            return false
        }
    }
    
    func buildRequest(lookup:USAutocompleteProLookup) -> SmartyRequest {
        let request = SmartyRequest()
        
        request.setValue(value: lookup.search ?? "", HTTPParameterField: "search")
        request.setValue(value: lookup.selected ?? "", HTTPParameterField: "selected")
        request.setValue(value: lookup.getMaxResultsStringIfSet(), HTTPParameterField: "max_result")
        request.setValue(value: buildFilterString(list: lookup.includeOnlyCities ?? [String]()), HTTPParameterField: "include_only_cities")
        request.setValue(value: buildFilterString(list: lookup.includeOnlyStates ?? [String]()), HTTPParameterField: "include_only_states")
        request.setValue(value: buildFilterString(list: lookup.includeOnlyZIPCodes ?? [String]()), HTTPParameterField: "include_only_zipcodes")
        request.setValue(value: buildFilterString(list: lookup.excludeStates ?? [String]()), HTTPParameterField: "exclude_states")
        request.setValue(value: buildFilterString(list: lookup.preferCities ?? [String]()), HTTPParameterField: "prefer_cities")
        request.setValue(value: buildFilterString(list: lookup.preferStates ?? [String]()), HTTPParameterField: "prefer_states")
        request.setValue(value: buildFilterString(list: lookup.preferZIPCodes ?? [String]()), HTTPParameterField: "prefer_zipcodes")
        request.setValue(value: lookup.getPreferRatioStringIfSet(), HTTPParameterField: "prefer_ratio")
        
        if lookup.preferGeolocation!.name != "none" {
            request.setValue(value: "true", HTTPParameterField: "geolocate")
            request.setValue(value: lookup.preferGeolocation!.name, HTTPParameterField: "prefer_geolocation")
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
