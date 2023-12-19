import Foundation

public class USEnrichmentClient: NSObject {
    
    private var sender:SmartySender
    private var propertyPrincipalSerializer:PropertyPrincipalSerializer
    private var propertyFinancialSerializer:PropertyFinancialSerializer
    
    init(sender:Any) {
        // Is is recommended to instantiate this class using SSClientBuilder
        
        self.sender = sender as! SmartySender
        self.propertyPrincipalSerializer = PropertyPrincipalSerializer()
        self.propertyFinancialSerializer = PropertyFinancialSerializer()
    }
    
    public func sendPropertyFinancialLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [FinancialResult]? {
        let lookup = PropertyFinancialEnrichmentLookup(smartyKey: smartyKey)
        let lookupPointer = UnsafeMutablePointer<EnrichmentLookup>.allocate(capacity: 1)
        lookupPointer.initialize(to: lookup)
        _ = send(lookup: lookupPointer, error: error)
        lookupPointer.deinitialize(count: 1)
        lookupPointer.deallocate()
        return lookup.results
    }
    
    public func sendPropertyPrincipalLookup(smartyKey: String, error: UnsafeMutablePointer<NSError?>) -> [PrincipalResult]? {
        let lookup = PropertyPrincipalEnrichmentLookup(smartyKey: smartyKey)
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
        
        var serializer:SmartySerializer? = nil
        
        if lookup.pointee is PropertyPrincipalEnrichmentLookup {
            serializer = self.propertyPrincipalSerializer
        } else if lookup.pointee is PropertyFinancialEnrichmentLookup {
            serializer = self.propertyFinancialSerializer
        }
        
        if let response = response {
            lookup.pointee.deserializeAndSetResults(serializer: serializer!, payload: response.payload, error: error)
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
