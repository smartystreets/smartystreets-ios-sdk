import XCTest
@testable import smartystreetsiOSSDKCore

class RetrySenderTests: XCTestCase {
    
    var request:SmartyRequest!
    var mockCrashingSender:MockCrashingSender!
    var mockLogger:MockLogger!
    var mockSleeper:MockSleeper!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.request = SmartyRequest()
        self.mockCrashingSender = MockCrashingSender()
        self.mockLogger = MockLogger()
        self.mockSleeper = MockSleeper()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.request = nil
        self.mockCrashingSender = nil
        self.mockLogger = nil
        self.mockSleeper = nil
        self.error = nil
    }
    
    func testSuccessDoesNotRetry() {
        self.request.urlPrefix = "DoNotRetry"
        let retrySender = RetrySender(maxRetries: 15, sleeper: self.mockSleeper as Any, logger: self.mockLogger as Any, inner: self.mockCrashingSender as Any)
        let _ = retrySender.sendRequest(request:self.request!, error: &self.error)
        //        sendRequest(requestBehavior: "RetryThreeTimes", error: &self.error)
        XCTAssertEqual(1, self.mockCrashingSender.sendCount)
    }
    
    func testRetryUntilSuccess() {
        self.request.urlPrefix = "RetryThreeTimes"
        let retrySender = RetrySender(maxRetries: 15, sleeper: self.mockSleeper as Any, logger: self.mockLogger as Any, inner: self.mockCrashingSender as Any)
        let _ = retrySender.sendRequest(request:self.request!, error: &self.error)
        XCTAssertEqual(4, self.mockCrashingSender.sendCount)
    }
    
    func testRetryUntilMaxAttempts() {
        self.request.urlPrefix = "RetryMaxTimes"
        let retrySender = RetrySender(maxRetries: 15, sleeper: self.mockSleeper as Any, logger: self.mockLogger as Any, inner: self.mockCrashingSender as Any)
        let _ = retrySender.sendRequest(request:self.request!, error: &self.error)
        XCTAssertNotNil(error)
    }
    
    func testBackoffDoesNotExceedMax() {
        let expectedDurations = [0,1,2,3,4,5,6,7,8,9,10,10,10,10]
        self.request.urlPrefix = "RetryFifteenTimes"
        let retrySender = RetrySender(maxRetries: 15, sleeper: self.mockSleeper as Any, logger: self.mockLogger as Any, inner: self.mockCrashingSender as Any)
        let _ = retrySender.sendRequest(request:self.request!, error: &self.error)
        XCTAssertEqual(self.mockCrashingSender.sendCount, 15)
        XCTAssertEqual(self.mockSleeper.sleepDuration as! [Int?], expectedDurations)
    }
}
