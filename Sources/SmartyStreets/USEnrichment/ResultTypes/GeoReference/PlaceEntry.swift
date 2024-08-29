import Foundation

public struct PlaceEntry: Codable {
    let accuracy, code, name, type: String?
    
    enum CodingKeys: String, CodingKey {
        case accuracy = "accuracy"
        case code = "code"
        case name = "name"
        case type = "type"
    }
}
