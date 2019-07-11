import XCTest
@testable import sdk

class SigningSenderTests: XCTestCase {
    
    var inner:MockSender!
    var signer:SmartyCredentials!
    var request:SmartyRequest!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.signer = StaticCredentials(authId: "authId", authToken: "secret")
        self.request = SmartyRequest()
        self.request.urlPrefix = "http://localhost/"
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.inner = nil
        self.signer = nil
        self.request = nil
        self.error = nil
    }
    
    
    func testSigningOfRequest() {
        self.inner = MockSender(response: nil)
        let sender = SigningSender(signer: self.signer, inner: self.inner as Any)
        let _ = sender.sendRequest(request: self.request, error: &self.error)
        
        let url = self.inner.request.getUrl()
        XCTAssertTrue(url.contains("http://localhost/?"))
        XCTAssertTrue(url.contains("auth-id=authId"))
        XCTAssertTrue(url.contains("auth-token=secret"))
    }
    
    func testSigningSendRequest() {
        let expectedResponse: SmartyResponse! = SmartyResponse(statusCode: 200, payload: Data())
        self.inner = MockSender(response: expectedResponse)
        let sender = SigningSender(signer: self.signer, inner: self.inner as Any)
        let response: SmartyResponse! = sender.sendRequest(request: self.request, error: &self.error)
        
        XCTAssertEqual(response.statusCode, expectedResponse.statusCode)
        XCTAssertEqual(response.payload, expectedResponse.payload)
    }
}
