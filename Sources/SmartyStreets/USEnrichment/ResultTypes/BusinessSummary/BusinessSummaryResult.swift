import Foundation

public struct BusinessSummaryResult: Codable {
    public let smartyKey: String?
    public let dataSetName: String?
    public let businesses: [BusinessEntry]?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case dataSetName = "data_set_name"
        case businesses
    }
}
