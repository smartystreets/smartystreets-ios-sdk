import Foundation

public class USStreetClient: NSObject {
    
    var sender:SmartySender
    var serializer:SmartySerializer
    
    public init(sender:Any, serializer:USStreetSerializer) {
        //        It is recommended to instantiate this class using SSClientBuilder
        
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    @objc public func sendLookup(lookup: UnsafeMutablePointer<USStreetLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Lookup object to the US Street API and stores the result in the Lookup's result field.
        
        let batch = USStreetBatch()
        _ = batch.add(newAddress: lookup.pointee, error: &error.pointee)
        let id = sendBatch(batch:batch, error: &error.pointee)
        lookup.pointee = batch.allLookups[0] as! USStreetLookup
        return id
    }
    
    @objc public func sendBatch(batch:USStreetBatch, error: UnsafeMutablePointer<NSError?>) -> Bool {
        //        Sends a Batch object containing no more than 100 Lookup objects to the US Street API and stores the
        //        results in the result field of the Lookup object.
        
        let request = SmartyRequest()
        
        if batch.count() == 0 {
            let details = [NSLocalizedDescriptionKey:"An address must be added before submitting a lookup"]
            error.pointee = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.ObjectNilError.rawValue, userInfo: details)
            return false
        }
        
        if batch.count() == 1 {
            for i in 0..<batch.count() {
                populateQueryString(lookup:batch.getLookupAtIndex(index: i) as! USStreetLookup, request:request)
            }
        } else {
            request.setPayload(payload:self.serializer.Serialize(obj: batch.allLookups as? [Any], error: &error.pointee) as Data)
        }
        
        let response = self.sender.sendRequest(request: request, error: &error.pointee)
        if error.pointee != nil {
            return false
        }
        
        var candidates:[USStreetCandidate]! = self.serializer.Deserialize(payload: response?.payload, error: &error.pointee) as? [USStreetCandidate]
        if error.pointee != nil {
            return false
        }
        
        if candidates == nil {
            candidates = [USStreetCandidate]()
        }
        
        assignCandidatesToLookups(lookups: batch.allLookups as! [USStreetLookup], candidates: candidates)
        checkLookupsForErrors(lookups: batch.allLookups as! [USStreetLookup], error: &error.pointee)
        
        return true
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func populateQueryString(lookup:USStreetLookup, request:SmartyRequest) {
        if lookup.matchStrategy == "enhanced" && lookup.maxCandidates == 1 {
            request.setValue(value: "5", HTTPParameterField: "candidates")
        } else {
            request.setValue(value: String(lookup.maxCandidates ?? 1), HTTPParameterField: "candidates")
        }
        populate(value: lookup.inputId, field: "input_id", request: request)
        populate(value: lookup.street, field: "street", request: request)
        populate(value: lookup.street2, field: "street2", request: request)
        populate(value: lookup.secondary, field: "secondary", request: request)
        populate(value: lookup.city, field: "city", request: request)
        populate(value: lookup.state, field: "state", request: request)
        populate(value: lookup.zipCode, field: "zipcode", request: request)
        populate(value: lookup.lastline, field: "lastline", request: request)
        populate(value: lookup.addressee, field: "addressee", request: request)
        populate(value: lookup.urbanization, field: "urbanization", request: request)
        populate(value: lookup.countySource, field: "county_source", request: request)
        populate(value: lookup.matchStrategy, field: "match", request: request)
        populate(value: lookup.outputFormat, field: "format", request: request)
        for key in lookup.getCustomParamArray().keys {
            populate(value: lookup.getCustomParamArray()[key], field: key, request: request)
        }

    }
    
    func populate(value:String!, field:String, request:SmartyRequest) {
        if let value = value {
            request.setValue(value: value, HTTPParameterField: field)
        }
    }
    
    func assignCandidatesToLookups(lookups: [USStreetLookup], candidates:[USStreetCandidate]) {
        for i in 0..<candidates.count {
            let candidate = candidates[i]
            let lookupIndex = candidate.inputIndex ?? -1
            if lookupIndex > -1 {
                if lookupIndex < lookups.count {
                    if lookups[lookupIndex].result == nil {
                        lookups[lookupIndex].result = [candidate]
                    } else {
                        lookups[lookupIndex].result.append(candidate)
                    }
                }
            }
        }
    }
    
    func checkLookupsForErrors(lookups:[USStreetLookup], error: inout NSError!) {
        for lookup in lookups {
            if let result = lookup.result {
                for candidate in result {
                    if let reason = candidate.reason, let status = candidate.status {
                        let details = [NSLocalizedDescriptionKey:"\n\tReason: \(reason)\n\tStatus: \(status)"]
                        error = NSError(domain: SmartyErrors().SSErrorDomain, code: SmartyErrors.SSErrors.BadRequestError.rawValue, userInfo: details)
                        return
                    }
                }
            }
        }
    }
}
