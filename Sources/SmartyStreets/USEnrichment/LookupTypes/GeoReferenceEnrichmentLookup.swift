import Foundation

public class GeoReferenceEnrichmentLookup: EnrichmentLookup {
    
    public var results:[GeoReferenceResult]?
    
    init(smartyKey: String){
        self.results = nil
        super.init(smartyKey: smartyKey, datasetName: "geo-reference", dataSubsetName: "")
    }
    
    override public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        self.results = serializer.Deserialize(payload: payload, error: &error.pointee) as? [GeoReferenceResult]
    }
}
