import Foundation

public struct FinancialResult: Codable {
    let smartyKey, dataSetName, dataSubsetName: String
    let attributes: FinancialAttributes

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case dataSetName = "data_set_name"
        case dataSubsetName = "data_subset_name"
        case attributes
    }
}
