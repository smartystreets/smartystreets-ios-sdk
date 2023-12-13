import Foundation

public class EnrichmentLookup: Encodable {
    private let smartyKey: String
    private let datasetName: String
    private let dataSubsetName: String

    public init(smartyKey: String, datasetName: String, dataSubsetName: String) {
        self.smartyKey = smartyKey
        self.datasetName = datasetName
        self.dataSubsetName = dataSubsetName
    }

    public func getSmartyKey() -> String {
        return smartyKey
    }

    public func getDatasetName() -> String {
        return datasetName
    }

    public func getDataSubsetName() -> String {
        return dataSubsetName
    }

    public func deserializeAndSetResults(serializer: SmartySerializer, payload: Data, error: UnsafeMutablePointer<NSError?>) {
        fatalError("You must use a Lookup subclass with an implemented version of deserializeAndSetResults")
    }
}
