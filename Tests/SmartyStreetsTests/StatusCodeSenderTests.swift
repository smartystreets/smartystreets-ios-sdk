import XCTest
@testable import SmartyStreets

class StatusCodeSenderTests: XCTestCase {
    
    var error: NSError!
    
    override func setUp() {
        super.setUp()
        self.error = NSError()
    }
    
    override func tearDown() {
        super.tearDown()
        self.error = nil
    }
    
    func test200Response() {
        let mockStatusCodeSender = MockStatusCodeSender(statusCode: 200)
        let sender = StatusCodeSender(inner: mockStatusCodeSender)
        
        let response = sender.sendRequest(request: SmartyRequest(), error: &self.error)
        
        XCTAssertEqual(response?.statusCode, 200)
    }
    
    func test400ResponseThrowsBadRequestError() {
        assertSendWithStatusCode(statusCode: 400)
    }

    func test401ResponseThrowsBadCredentialsError() {
        assertSendWithStatusCode(statusCode: 401)
    }

    func test402ResponseThrowsPaymentRequiredError() {
        assertSendWithStatusCode(statusCode: 402)
    }

    func test413ResponseThrowsRequeestEntityTooLargeError() {
        assertSendWithStatusCode(statusCode: 413)
    }

    func test422ResponseThrowsUnprocessableEntityError() {
        assertSendWithStatusCode(statusCode: 422)
    }

    // MARK: - Fallback message (payload has no parseable error)

    func test400ResponseUsesFallbackMessage() {
        assertFallbackMessage(statusCode: 400, expectedFallback: "Bad Request (Malformed Payload): A GET request lacked a street field or the request body of a POST request contained malformed JSON.")
    }

    func test401ResponseUsesFallbackMessage() {
        assertFallbackMessage(statusCode: 401, expectedFallback: "Unauthorized: The credentials were provided incorrectly or did not match any existing, active credentials.")
    }

    func test402ResponseUsesFallbackMessage() {
        assertFallbackMessage(statusCode: 402, expectedFallback: "Payment Required: There is no active subscription for the account associated with the credentials submitted with the request.")
    }

    func test413ResponseUsesFallbackMessage() {
        assertFallbackMessage(statusCode: 413, expectedFallback: "Request Entity Too Large: The request body has exceeded the maximum size.")
    }

    func test422ResponseUsesFallbackMessage() {
        assertFallbackMessage(statusCode: 422, expectedFallback: "GET request lacked required fields.")
    }

    // MARK: - Parsed message (payload carries an error message)

    func test400ResponseUsesParsedMessage() {
        assertParsedMessage(statusCode: 400)
    }

    func test401ResponseUsesParsedMessage() {
        assertParsedMessage(statusCode: 401)
    }

    func test402ResponseUsesParsedMessage() {
        assertParsedMessage(statusCode: 402)
    }

    func test413ResponseUsesParsedMessage() {
        assertParsedMessage(statusCode: 413)
    }

    func test422ResponseUsesParsedMessage() {
        assertParsedMessage(statusCode: 422)
    }

    func test429ResponseThrowsTooManyRequestsError() {
        assertSendWithStatusCode(statusCode: 429)
    }
    
    func test429ResponseMessage() {
        assertSendWithStatusCodeAndMessage(statusCode: 429, message:
                                            """
                                           {"errors":[{"id": 1234, "message": "Why so aggressive?"}]}
                                           """
        )
    }
    
    func test500ResponseThrowsInternalServerError() {
        assertSendWithStatusCode(statusCode: 500)
    }
    
    func test503ResponseThrowsServiceUnavailableError() {
        assertSendWithStatusCode(statusCode: 503)
    }
    
    func test504ResponseThrowsGatewayTimeoutException() {
        assertSendWithStatusCode(statusCode: 504)
    }
    
    func testNotModifiedCarriesResponseEtagFromHeader() {
        let inner = MockSender(statusCode: 304, payload: Data(), headers: ["Etag": "server-refreshed-etag"])
        let sender = StatusCodeSender(inner: inner)

        let _ = sender.sendRequest(request: SmartyRequest(), error: &self.error)

        XCTAssertEqual(304, self.error.code)
        XCTAssertEqual("server-refreshed-etag", self.error.userInfo[SmartyErrors.ResponseEtagKey] as? String)
    }

    func testNotModifiedResponseEtagHeaderCaseInsensitive() {
        let inner = MockSender(statusCode: 304, payload: Data(), headers: ["ETag": "case-insensitive-etag"])
        let sender = StatusCodeSender(inner: inner)

        let _ = sender.sendRequest(request: SmartyRequest(), error: &self.error)

        XCTAssertEqual(304, self.error.code)
        XCTAssertEqual("case-insensitive-etag", self.error.userInfo[SmartyErrors.ResponseEtagKey] as? String)
    }

    func testNotModifiedNoHeaderLeavesResponseEtagAbsent() {
        let inner = MockSender(statusCode: 304, payload: Data(), headers: [:])
        let sender = StatusCodeSender(inner: inner)

        let _ = sender.sendRequest(request: SmartyRequest(), error: &self.error)

        XCTAssertEqual(304, self.error.code)
        XCTAssertNil(self.error.userInfo[SmartyErrors.ResponseEtagKey])
    }

    func assertSendWithStatusCode(statusCode:Int) {
        let mockStatusCodeSender = MockStatusCodeSender(statusCode: statusCode)
        let sender = StatusCodeSender(inner: mockStatusCodeSender)

        let _ = sender.sendRequest(request: SmartyRequest(), error: &self.error)

        XCTAssertEqual(statusCode, self.error.code)
    }

    func assertFallbackMessage(statusCode:Int, expectedFallback:String) {
        let mockStatusCodeSender = MockStatusCodeSender(statusCode: statusCode)
        let sender = StatusCodeSender(inner: mockStatusCodeSender)

        let response = sender.sendRequest(request: SmartyRequest(), error: &self.error)

        XCTAssertNil(response, "status \(statusCode) should return a nil response")
        XCTAssertEqual(statusCode, self.error.code)
        XCTAssertEqual(expectedFallback, self.error.localizedDescription)
    }

    func assertParsedMessage(statusCode:Int) {
        let message = "server-supplied message for \(statusCode)"
        let mockStatusCodeSender = MockStatusCodeSender(statusCode: statusCode, payload: """
            {"errors":[{"id": 1234, "message": "\(message)"}]}
            """)
        let sender = StatusCodeSender(inner: mockStatusCodeSender)

        let response = sender.sendRequest(request: SmartyRequest(), error: &self.error)

        XCTAssertNil(response, "status \(statusCode) should return a nil response")
        XCTAssertEqual(statusCode, self.error.code)
        XCTAssertEqual(message, self.error.localizedDescription)
    }
    
    func assertSendWithStatusCodeAndMessage(statusCode:Int, message:String) {
        let mockStatusCodeSender = MockStatusCodeSender(statusCode: statusCode, payload: message)
        let sender = StatusCodeSender(inner: mockStatusCodeSender)
        
        let _ = sender.sendRequest(request: SmartyRequest(), error: &self.error)
        
        XCTAssertEqual(statusCode, self.error.code)
        XCTAssertEqual("Too Many Requests: Why so aggressive?", self.error.localizedDescription)
    }
}
