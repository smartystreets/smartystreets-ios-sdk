import Foundation

public class USEnrichmentClient: NSObject {
    
    var sender:SmartySender
    var serializer:SmartySerializer
    
    init(sender:Any, serializer:USReverseGeoSerializer) {
        // Is is recommended to instantiate this class using SSClientBuilder
        
        self.sender = sender as! SmartySender
        self.serializer = serializer
    }
    
    public func sendPropertyFinancialLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [FinancialAttributes]? {
        var lookup = PropertyFinancialEnrichmentLookup(smartyKey: smartyKey)
        let lookupPointer = UnsafeMutablePointer<EnrichmentLookup>.allocate(capacity: 1)
        lookupPointer.initialize(to: lookup)
        _ = send(lookup: lookupPointer, error: error)
        lookupPointer.deinitialize(count: 1)
        lookupPointer.deallocate()
        return lookup.results
    }
    
    public func sendPropertyPrincipalLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [PrincipalAttributes]? {
        var lookup = PropertyPrincipalEnrichmentLookup(smartyKey: smartyKey)
        let lookupPointer = UnsafeMutablePointer<EnrichmentLookup>.allocate(capacity: 1)
        lookupPointer.initialize(to: lookup)
        _ = send(lookup: lookupPointer, error: error)
        lookupPointer.deinitialize(count: 1)
        lookupPointer.deallocate()
        return lookup.results
    }
    
    private func send(lookup: UnsafeMutablePointer<EnrichmentLookup>, error: UnsafeMutablePointer<NSError?>) -> Bool {
        
        if error.pointee != nil { return false }
        
        let request = buildRequest(lookup: lookup.pointee)
        
        let response = sender.sendRequest(request: request, error: &error.pointee)
        if error.pointee != nil { return false }
        
        if let response = response {
            lookup.pointee.deserializeAndSetResults(serializer: self.serializer, payload: response.payload, error: error)
        }
        
        if error.pointee != nil { return false }
        
        return true
    }
    
    func buildRequest(lookup:EnrichmentLookup) -> SmartyRequest {
        let request = SmartyRequest()
        request.urlPrefix = "/" + lookup.getSmartyKey() + "/" + lookup.getDatasetName() + "/" + lookup.getDataSubsetName()
        return request
    }
}
