import Foundation

@objcMembers public class LanguageMode: NSObject, Codable {
    
    var Native = "native"
    var Latin = "latin"
    var name:String
    
    init(name:String) {
        self.name = name
    }
}
