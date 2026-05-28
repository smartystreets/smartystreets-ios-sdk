import Foundation

@objcMembers public class LanguageMode: NSObject, Codable {
    
    public static let Native = "native"
    public static let Latin = "latin"
    public let name:String

    public init(name:String) {
        self.name = name
    }
}
