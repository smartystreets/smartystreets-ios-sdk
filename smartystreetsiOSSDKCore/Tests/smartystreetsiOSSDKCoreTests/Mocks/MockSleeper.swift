import Foundation
@testable import smartystreetsiOSSDKCore

class MockSleeper: SmartySleeper {
    
    var sleepDuration:NSMutableArray
    
    override init() {
        self.sleepDuration = NSMutableArray()
    }
    
    override func sleep(seconds: Int) {
        self.sleepDuration.add(seconds)
    }
}
