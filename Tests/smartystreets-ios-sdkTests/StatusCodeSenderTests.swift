import XCTest
@testable import smartystreets_ios_sdk

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
    
    func test429ResponseThrowsTooManyRequestsError() {
        assertSendWithStatusCode(statusCode: 429)
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
    
    func assertSendWithStatusCode(statusCode:Int) {
        let mockStatusCodeSender = MockStatusCodeSender(statusCode: statusCode)
        let sender = StatusCodeSender(inner: mockStatusCodeSender)
        
        let _ = sender.sendRequest(request: SmartyRequest(), error: &self.error)
        
        XCTAssertEqual(statusCode, self.error.code)
    }
}
