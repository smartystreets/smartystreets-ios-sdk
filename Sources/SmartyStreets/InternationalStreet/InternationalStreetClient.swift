import Foundation

public class InternationalStreetClient: NSObject {
    
    var sender:SmartySender
    var serializer:SmartySerializer
    
    init(sender:Any, serializer:InternationalStreetSerializer) {
        // Is is recommended to instantiate this class using SSClientBuilder
        
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<InternationalStreetLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        // Sends a Lookup object to the International Street API and stores the result in the Lookup's result field.
        
        ensureEnoughInfo(lookup:lookup.pointee, error:&error.pointee)
        if error.pointee != nil { return false }
        
        let request = buildRequest(lookup:lookup.pointee)
        
        let response = sender.sendRequest(request: request, error: &error.pointee)
        if error.pointee != nil { return false }
        
        let candidates:[InternationalStreetCandidate]! = serializer.Deserialize(payload: response?.payload, error: &error.pointee) as? [InternationalStreetCandidate]
        if error.pointee != nil { return false }
        lookup.pointee.result = candidates
        
        return true
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func buildRequest(lookup:InternationalStreetLookup) -> SmartyRequest {
        let request = SmartyRequest()
        
        request.setValue(value: lookup.country ?? "", HTTPParameterField: "country")
        request.setValue(value: lookup.geocode ?? "", HTTPParameterField: "geocode")
        if let language = lookup.language {
            request.setValue(value: language.name, HTTPParameterField: "language")
        }
        request.setValue(value: lookup.freeform ?? "", HTTPParameterField: "freeform")
        request.setValue(value: lookup.address1 ?? "", HTTPParameterField: "address1")
        request.setValue(value: lookup.address2 ?? "", HTTPParameterField: "address2")
        request.setValue(value: lookup.address3 ?? "", HTTPParameterField: "address3")
        request.setValue(value: lookup.address4 ?? "", HTTPParameterField: "address4")
        request.setValue(value: lookup.organization ?? "", HTTPParameterField: "organization")
        request.setValue(value: lookup.locality ?? "", HTTPParameterField: "locality")
        request.setValue(value: lookup.administrativeArea ?? "", HTTPParameterField: "administrative_area")
        request.setValue(value: lookup.postalCode ?? "", HTTPParameterField: "postal_code")
        request.setValue(value: lookup.features ?? "", HTTPParameterField: "features")
        
        for key in lookup.getCustomParamArray().keys {
            request.setValue(value: lookup.getCustomParamArray()[key] ?? "", HTTPParameterField: key)
        }
        
        return request
    }
    
    func ensureEnoughInfo(lookup:InternationalStreetLookup, error: inout NSError!) {
        let smartyError = SmartyErrors()
        if lookup.missingCountry() {
            let details = [NSLocalizedDescriptionKey:"Country field is required."]
            error = NSError(domain: smartyError.SSErrorDomain, code: SmartyErrors.SSErrors.UnprocessableEntityError.rawValue, userInfo: details)
            return
        }
        
        if lookup.hasFreeform() {
            return
        }
        
        if lookup.missingAddress1() {
            let details = [NSLocalizedDescriptionKey:"Either freeform or address1 is required."]
            error = NSError(domain: smartyError.SSErrorDomain, code: SmartyErrors.SSErrors.UnprocessableEntityError.rawValue, userInfo: details)
            return
        }
        
        if lookup.hasPostalCode() {
            return
        }
        
        if lookup.missingLocalityOrAdministrativeArea() {
            let details = [NSLocalizedDescriptionKey:"Insufficient information: One or more required fields were not set on the lookup."]
            error = NSError(domain: smartyError.SSErrorDomain, code: SmartyErrors.SSErrors.UnprocessableEntityError.rawValue, userInfo: details)
            return
        }
    }
}
