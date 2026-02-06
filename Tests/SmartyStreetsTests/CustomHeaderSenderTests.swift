import XCTest
@testable import SmartyStreets

class CustomHeaderSenderTests: XCTestCase {

    var request:SmartyRequest!
    var mockSender:MockSender!
    var error:NSError!

    override func setUp() {
        super.setUp()
        self.request = SmartyRequest()
        self.mockSender = MockSender()
        self.error = nil
    }

    override func tearDown() {
        super.tearDown()
        self.request = nil
        self.mockSender = nil
        self.error = nil
    }

    func testCustomHeadersAreAddedToRequest() {
        let headers = ["X-Custom": "value1", "X-Other": "value2"]
        let sender = CustomHeaderSender(headers: headers, inner: self.mockSender!)
        let _ = sender.sendRequest(request: self.request!, error: &self.error)
        XCTAssertEqual("value1", self.mockSender.request.headers["X-Custom"])
        XCTAssertEqual("value2", self.mockSender.request.headers["X-Other"])
    }

    func testEmptyHeadersDoNotModifyRequest() {
        let headers:[String:String] = [:]
        let sender = CustomHeaderSender(headers: headers, inner: self.mockSender!)
        let _ = sender.sendRequest(request: self.request!, error: &self.error)
        XCTAssertEqual(0, self.mockSender.request.headers.count)
    }

    func testUserAgentHeaderIsSet() {
        let version = Version().version
        let headers = ["User-Agent": "smartystreets (sdk:ios@\(version))"]
        let sender = CustomHeaderSender(headers: headers, inner: self.mockSender!)
        let _ = sender.sendRequest(request: self.request!, error: &self.error)
        XCTAssertEqual("smartystreets (sdk:ios@\(version))", self.mockSender.request.headers["User-Agent"])
    }

    func testCustomUserAgentIsAppended() {
        let version = Version().version
        let headers = ["User-Agent": "smartystreets (sdk:ios@\(version)) my-app/1.0"]
        let sender = CustomHeaderSender(headers: headers, inner: self.mockSender!)
        let _ = sender.sendRequest(request: self.request!, error: &self.error)
        XCTAssertEqual("smartystreets (sdk:ios@\(version)) my-app/1.0", self.mockSender.request.headers["User-Agent"])
    }
}
