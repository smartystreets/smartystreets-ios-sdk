import Foundation

public struct CoreBasedStatAreaEntry: Codable {
    let code, name: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
    }
}
