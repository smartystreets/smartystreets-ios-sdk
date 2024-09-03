import Foundation

public class SecondaryEnrichmentLookup: EnrichmentLookup {
    
    public var results:[SecondaryResult]?
    
    init(smartyKey: String){
        self.results = nil
        super.init(smartyKey: smartyKey, datasetName: "secondary", dataSubsetName: "")
    }
    
    override public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        self.results = serializer.Deserialize(payload: payload, error: &error.pointee) as? [SecondaryResult]
    }
}
