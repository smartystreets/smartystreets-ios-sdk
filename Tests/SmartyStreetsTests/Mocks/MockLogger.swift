import Foundation
@testable import SmartyStreets

class MockLogger: SmartyLogger {
    
    var log = NSMutableArray()
    
    override func log(message: String) {
        self.log.add(message)
    }
}
