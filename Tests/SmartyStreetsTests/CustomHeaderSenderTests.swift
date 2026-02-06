import XCTest
@testable import SmartyStreets

class CustomHeaderSenderTests: XCTestCase {

    var inner:MockSender!
    var request:SmartyRequest!
    var error:NSError!

    override func setUp() {
        super.setUp()
        self.inner = MockSender(response: nil)
        self.request = SmartyRequest()
        self.error = nil
    }

    override func tearDown() {
        super.tearDown()
        self.inner = nil
        self.request = nil
        self.error = nil
    }

    func testAllCustomHeadersAreAddedToTheRequest() {
        let headers:[String:[String]] = [
            "A": ["value-a"],
            "B": ["value-b"],
        ]
        let sender = CustomHeaderSender(headers: headers, appendHeaders: [:], inner: self.inner)

        _ = sender.sendRequest(request: self.request, error: &self.error)

        XCTAssertEqual(self.inner.request.headers["A"], "value-a")
        XCTAssertEqual(self.inner.request.headers["B"], "value-b")
    }

    func testAppendedHeadersAreJoinedWithSeparator() {
        let headers:[String:[String]] = [
            "User-Agent": ["base-value", "custom-value"],
        ]
        let appendHeaders = ["User-Agent": " "]
        let sender = CustomHeaderSender(headers: headers, appendHeaders: appendHeaders, inner: self.inner)

        _ = sender.sendRequest(request: self.request, error: &self.error)

        XCTAssertEqual(self.inner.request.headers["User-Agent"], "base-value custom-value")
    }

    func testNonAppendedHeaderUsesLastValue() {
        let headers:[String:[String]] = [
            "X-Custom": ["first", "second"],
        ]
        let sender = CustomHeaderSender(headers: headers, appendHeaders: [:], inner: self.inner)

        _ = sender.sendRequest(request: self.request, error: &self.error)

        XCTAssertEqual(self.inner.request.headers["X-Custom"], "second")
    }

    func testRequestIsPassedToInnerSender() {
        let sender = CustomHeaderSender(headers: [:], appendHeaders: [:], inner: self.inner)

        _ = sender.sendRequest(request: self.request, error: &self.error)

        XCTAssertNotNil(self.inner.request)
    }
}
