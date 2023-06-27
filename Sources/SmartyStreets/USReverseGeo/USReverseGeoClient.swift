import Foundation

public class USReverseGeoClient: NSObject {
    
    var sender:SmartySender
    var serializer:SmartySerializer
    
    init(sender:Any, serializer:USReverseGeoSerializer) {
        // Is is recommended to instantiate this class using SSClientBuilder
        
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<USReverseGeoLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        // Sends a Lookup object to the US Reverse Geo API and stores the result in the Lookup's response field.
        
        if error.pointee != nil { return false }
        
        let request = buildRequest(lookup:lookup.pointee)
        
        let response = sender.sendRequest(request: request, error: &error.pointee)
        if error.pointee != nil { return false }
        
        let result:USReverseGeoResponse? = self.serializer.Deserialize(payload: response?.payload, error: &error.pointee) as? USReverseGeoResponse
        
        if error.pointee != nil { return false }
        lookup.pointee.response = result
        
        return true
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func buildRequest(lookup:USReverseGeoLookup) -> SmartyRequest {
        let request = SmartyRequest()
        
        request.setValue(value: lookup.latitude, HTTPParameterField: "latitude")
        request.setValue(value: lookup.longitude, HTTPParameterField: "longitude")
        request.setValue(value: lookup.source, HTTPParameterField: "source")

        return request
    }
}
