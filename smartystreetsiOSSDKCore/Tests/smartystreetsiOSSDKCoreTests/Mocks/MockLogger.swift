import Foundation
@testable import smartystreetsiOSSDKCore

class MockLogger: SmartyLogger {
    
    var log = NSMutableArray()
    
    override func log(message: String) {
        self.log.add(message)
    }
}
