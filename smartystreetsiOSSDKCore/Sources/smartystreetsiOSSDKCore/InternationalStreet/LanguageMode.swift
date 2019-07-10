import Foundation

@objcMembers class LanguageMode: NSObject, Codable {
    
    let Native = "native"
    let Latin = "latin"
    var name:String
    
    init(name:String) {
        self.name = name
    }
}
