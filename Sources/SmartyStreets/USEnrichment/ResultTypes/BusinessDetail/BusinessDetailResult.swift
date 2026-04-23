import Foundation

public struct BusinessDetailResult: Codable {
    public let smartyKey: String?
    public let dataSetName: String?
    public let businessId: String?
    public let attributes: BusinessDetailAttributes?

    enum CodingKeys: String, CodingKey {
        case smartyKey = "smarty_key"
        case dataSetName = "data_set_name"
        case businessId = "business_id"
        case attributes
    }
}
