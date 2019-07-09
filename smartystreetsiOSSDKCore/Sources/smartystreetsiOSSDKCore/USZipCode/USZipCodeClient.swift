import Foundation

@objcMembers public class USZipCodeClient: NSObject {
    var sender:SmartySender
    var serializer:SmartySerializer
    
    public init(sender:Any, serializer:USZipCodeSerializer) {
        //        It is recommended to instantiate this class using SSClientBuilder
        
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<USZipCodeLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Lookup object to the US ZIP Code API and stores the result in the Lookup's result field.
        
        let batch = USZipCodeBatch()
        let _ = batch.add(newAddress: lookup, error: &error.pointee)
        let id = sendBatch(batch:batch, error: &error.pointee)
        lookup.pointee = batch.allLookups[0] as! USZipCodeLookup
        return id
    }
    
    public func sendBatch(batch:USZipCodeBatch, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Batch object containing no more than 100 Lookup objects to the US ZIP Code API and stores the
        //        results in the result field of the Lookup object.
        
        let request = SmartyRequest()
        
        if batch.count() == 0 {
            let details = [NSLocalizedDescriptionKey:"A zip or city/state must be added before submitting a lookup"]
            error.pointee = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.ObjectNilError.rawValue, userInfo: details)
            return false
        }
        
        if batch.count() == 1 {
            for i in 0..<batch.count() {
                populateQueryString(lookup:batch.getLookupAtIndex(index: i) as! USZipCodeLookup, request:request)
            }
        } else {
            request.setPayload(payload:self.serializer.Serialize(obj: batch.allLookups as? [Any], error: &error.pointee) as Data)
        }
        
        let response = self.sender.sendRequest(request: request, error: &error.pointee)
        if error.pointee != nil {
            return false
        }
        
        var results:[USZipCodeResult]! = self.serializer.Deserialize(payload: response?.payload, error: &error.pointee) as? [USZipCodeResult]
        if error.pointee != nil {
            return false
        }
        
        if results == nil {
            results = [USZipCodeResult]()
        }
        
        assignResultsToLookups(lookups: batch.allLookups as! [USZipCodeLookup], results:results)
        checkLookupsForErrors(lookups: batch.allLookups as! [USZipCodeLookup], error: &error.pointee)
        
        return true
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func populateQueryString(lookup:USZipCodeLookup, request:SmartyRequest) {
        populate(value: lookup.inputId, field: "input_id", request: request)
        populate(value: lookup.city, field: "city", request: request)
        populate(value: lookup.state, field: "state", request: request)
        populate(value: lookup.zipcode, field: "zipcode", request: request)
    }
    
    func populate(value:String!, field:String, request:SmartyRequest) {
        if let value = value {
            request.setValue(value: value, HTTPParameterField: field)
        }
    }
    
    func assignResultsToLookups(lookups:[USZipCodeLookup], results:[USZipCodeResult]) {
        for i in 0..<results.count {
            lookups[i].result = results[i]
        }
    }
    
    func checkLookupsForErrors(lookups:[USZipCodeLookup], error: inout NSError!) {
        var counter = 0
        for lookup in lookups {
            counter += 1
            if let result = lookup.result, let reason = result.reason, let status = result.status {
                let details = [NSLocalizedDescriptionKey:"\n\tReason: \(reason)\n\tStatus: \(status)"]
                error = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.BadRequestError.rawValue, userInfo: details)
                return
            }
        }
    }
}
