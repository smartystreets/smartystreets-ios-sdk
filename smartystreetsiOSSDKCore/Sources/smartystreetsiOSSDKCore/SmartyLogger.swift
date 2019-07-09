import Foundation

@objc class SmartyLogger: NSObject {
    
    @objc func log(message: String) {
        NSLog("%@", "\n\(message)")
    }
}
