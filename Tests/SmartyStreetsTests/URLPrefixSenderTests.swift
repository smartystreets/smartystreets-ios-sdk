import XCTest
@testable import SmartyStreets

class URLPrefixSenderTests: XCTestCase {

    var urlPrefixSender:URLPrefixSender!
    var inner:MockSender!
    var error:NSError!

    override func setUp() {
        super.setUp()
        self.inner = MockSender(response: nil)
        self.urlPrefixSender = URLPrefixSender(urlPrefix: "http://mysite.com/lookup", inner: self.inner as Any)
    }

    override func tearDown() {
        super.tearDown()
        self.urlPrefixSender = nil
        self.error = nil
        self.inner = nil
    }

    func testRequestURLPresent() {
        let request:SmartyRequest = SmartyRequest()
        request.urlPrefix = "/jimbo"

        _ = self.urlPrefixSender.sendRequest(request: request, error: &self.error)

        XCTAssertEqual(request.urlPrefix, "http://mysite.com/lookup/jimbo")

    }

    func testRequestURLNotPresent() {
        let request:SmartyRequest = SmartyRequest()

        _ = self.urlPrefixSender.sendRequest(request: request, error: &self.error)

        XCTAssertEqual(request.urlPrefix, "http://mysite.com/lookup")
    }


}