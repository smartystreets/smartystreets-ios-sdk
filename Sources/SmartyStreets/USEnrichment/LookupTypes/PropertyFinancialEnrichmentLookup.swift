import Foundation

public class PropertyFinancialEnrichmentLookup: EnrichmentLookup {
    
    public var results:[FinancialAttributes]?
    
    init(smartyKey: String){
        self.results = nil
        super.init(smartyKey: smartyKey, datasetName: "property", dataSubsetName: "financial")
    }
    
    override public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        self.results = serializer.Deserialize(payload: payload, error: &error.pointee) as? [FinancialAttributes]
    }
    
    
}
