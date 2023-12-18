import Foundation

public class EnrichmentLookup: Encodable {
    private let smarty_key: String
    private let data_set_name: String
    private let data_subset_name: String

    public init(smartyKey: String, datasetName: String, dataSubsetName: String) {
        self.smarty_key = smartyKey
        self.data_set_name = datasetName
        self.data_subset_name = dataSubsetName
    }

    public func getSmartyKey() -> String {
        return smarty_key
    }

    public func getDatasetName() -> String {
        return data_set_name
    }

    public func getDataSubsetName() -> String {
        return data_subset_name
    }

    public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        fatalError("You must use a Lookup subclass with an implemented version of deserializeAndSetResults")
    }
}
