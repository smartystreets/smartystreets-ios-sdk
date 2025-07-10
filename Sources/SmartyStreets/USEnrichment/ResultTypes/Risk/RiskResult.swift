import Foundation

public struct RiskResult: Codable {
    public let smartyKey, dataSetName, dataSubsetName: String?
    public let attributes: RiskAttributes?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case dataSetName = "data_set_name"
        case dataSubsetName = "data_subset_name"
        case attributes
    }
}
