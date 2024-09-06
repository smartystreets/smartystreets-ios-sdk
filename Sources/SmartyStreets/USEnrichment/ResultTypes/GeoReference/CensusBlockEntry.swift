import Foundation

public struct CensusBlockEntry: Codable {
    let accuracy, geoid: String?
    
    enum CodingKeys: String, CodingKey {
        case accuracy = "accuracy"
        case geoid = "geoid"
    }
}
