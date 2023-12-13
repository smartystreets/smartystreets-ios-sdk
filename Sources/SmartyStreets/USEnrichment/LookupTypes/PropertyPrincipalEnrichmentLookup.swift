import Foundation

public class PropertyPrincipalEnrichmentLookup: EnrichmentLookup {
    
    public var results:[PrincipalAttributes]?
    
    init(smartyKey: String){
        self.results = nil
        super.init(smartyKey: smartyKey, datasetName: "property", dataSubsetName: "principal")
    }
    
    override public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        self.results = serializer.Deserialize(payload: payload, error: &error.pointee) as? [PrincipalAttributes]
    }
}
