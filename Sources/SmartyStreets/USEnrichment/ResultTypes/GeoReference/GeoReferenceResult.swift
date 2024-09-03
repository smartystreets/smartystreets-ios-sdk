import Foundation

public struct GeoReferenceResult: Codable {
    public let smartyKey, dataSetName, dataSubsetName: String?
    public let attributes: GeoReferenceAttributes?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case dataSetName = "data_set_name"
        case dataSubsetName = "data_subset_name"
        case attributes
    }
}
