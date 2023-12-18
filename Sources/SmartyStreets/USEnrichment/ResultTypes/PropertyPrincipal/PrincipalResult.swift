import Foundation

public struct PrincipalResult: Codable {
    let smartyKey, dataSetName, dataSubsetName: String
    let attributes: PrincipalAttributes

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case dataSetName = "data_set_name"
        case dataSubsetName = "data_subset_name"
        case attributes
    }
}
