import Foundation
@testable import smartystreets_ios_sdk

class MockLogger: SmartyLogger {
    
    var log = NSMutableArray()
    
    override func log(message: String) {
        self.log.add(message)
    }
}
