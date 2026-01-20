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
        return sendLookupWithAuth(lookup: lookup, authId: nil, authToken: nil, error: error)
    }

    @objc public func sendLookupWithAuth(lookup: UnsafeMutablePointer<USReverseGeoLookup>, authId:String?, authToken:String?, error: UnsafeMutablePointer<NSError?>) -> Bool {
        // Sends a Lookup object with per-request credentials.
        // If authId and authToken are both non-empty, they will be used for this request instead of the client-level credentials.
        // This is useful for multi-tenant scenarios where different requests require different credentials.

        if error.pointee != nil { return false }

        let request = buildRequest(lookup:lookup.pointee)

        if let authId = authId, let authToken = authToken, !authId.isEmpty, !authToken.isEmpty {
            let credentials = "\(authId):\(authToken)"
            if let credentialsData = credentials.data(using: .utf8) {
                let base64Credentials = credentialsData.base64EncodedString()
                request.setValue(value: "Basic \(base64Credentials)", HTTPHeaderField: "Authorization")
            }
        }

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
        for key in lookup.getCustomParamArray().keys {
            request.setValue(value: lookup.getCustomParamArray()[key] ?? "", HTTPParameterField: key)
        }

        return request
    }
}
