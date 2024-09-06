import Foundation

public struct CensusTractEntry: Codable {
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
    }
}
