import Foundation

public struct BusinessEntry: Codable {
    public let companyName: String?
    public let businessId: String?

    enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case businessId = "business_id"
    }
}
