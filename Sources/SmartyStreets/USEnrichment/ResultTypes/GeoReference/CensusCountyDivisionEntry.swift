import Foundation

public struct CensusCountyDivisionEntry: Codable {
    let accuracy, code, name: String?
    
    enum CodingKeys: String, CodingKey {
        case accuracy = "accuracy"
        case code = "code"
        case name = "name"
    }
}
