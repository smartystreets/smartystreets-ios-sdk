import XCTest
@testable import SmartyStreets

class SmartySenderTests: XCTestCase {
    
    var signer:SmartyCredentials!
    var request:SmartyRequest!
    var inner:MockSender!
    var response:SmartyResponse!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.signer = StaticCredentials(authId: "authId", authToken: "secret")
        self.response = nil
        self.inner = MockSender(response: self.response)
        self.request = SmartyRequest()
        self.request.setValue(value: "application/json", HTTPHeaderField: "accept")
        self.request.urlPrefix = "http://localhost/"
        self.request.setValue(value: "84664", HTTPParameterField: "zipcode")
        self.request.referer = "Referer"
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.inner = nil
        self.signer = nil
        self.request = nil
        self.error = nil
    }
    
    func testCustomizeInitHttpSender() {
        let sender = HttpSender(maxTimeout: 20000, proxy: [1:2], debug:true)
        XCTAssertEqual(sender.maxTimeout, 20000)
        XCTAssertNotNil(sender.proxy)
        XCTAssertEqual(sender.debug, true)
    }
    
    func testBuildHttpRequestFuncOnHTTP() {
        let sender = HttpSender()
        let httpRequest = sender.buildHttpRequest(request: self.request)
        XCTAssertEqual(httpRequest.httpMethod!, "GET")
    }
    
    func testCopyHeadersFuncOnHTTP() {
        let sender = HttpSender()
        var httpRequest = sender.buildHttpRequest(request: self.request)
        sender.copyHeaders(request: self.request, httpRequest: &httpRequest)
        XCTAssertNotNil(httpRequest.allHTTPHeaderFields!["User-Agent"])
    }
    
    func testDebugger() {
        let expectedPayload = "Hello, World!"
        let mockPayload = expectedPayload.data(using: .utf8)
        self.request.payload = mockPayload
        let sender = HttpSender()
        let httpRequest = sender.buildHttpRequest(request: self.request)
        let mockResponse = HTTPURLResponse(url: URL(fileURLWithPath: self.request.urlPrefix), statusCode: 200, httpVersion: String(), headerFields: ["Test Header": "Test Value"])
        let debugMessage = sender.logHttpRequest(httpRequest: httpRequest, response: mockResponse, payload: mockPayload)
        XCTAssert(debugMessage.contains("Method: \(httpRequest.httpMethod!)"))
        XCTAssert(debugMessage.contains("URL: \(httpRequest.url!)"))
        XCTAssert(debugMessage.contains("Headers: \(httpRequest.allHTTPHeaderFields!)"))
        
        XCTAssert(debugMessage.contains("\(mockResponse!.allHeaderFields)"))
        XCTAssert(debugMessage.contains("Status: \(mockResponse!.statusCode)"))
        XCTAssert(debugMessage.contains("\(mockPayload ?? Data())"))
    }
}
