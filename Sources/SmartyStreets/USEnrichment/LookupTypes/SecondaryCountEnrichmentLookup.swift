import Foundation

public class SecondaryCountEnrichmentLookup: EnrichmentLookup {
    
    public var results:[SecondaryCountResult]?
    
    init(smartyKey: String){
        self.results = nil
        super.init(smartyKey: smartyKey, datasetName: "secondary", dataSubsetName: "count")
    }
    
    override public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        self.results = serializer.Deserialize(payload: payload, error: &error.pointee) as? [SecondaryCountResult]
    }
}
