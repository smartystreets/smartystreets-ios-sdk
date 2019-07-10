import XCTest
@testable import smartystreetsiOSSDKCore

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
}
