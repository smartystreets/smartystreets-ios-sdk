import XCTest
@testable import SmartyStreets

class SmartyCredentialsTests: XCTestCase {
    
    var authId = "abc"
    var authToken = "123"
    var staticCredentials:StaticCredentials!
    var sharedCredentials:SharedCredentials!
    var request:SmartyRequest!
    
    override func setUp() {
        super.setUp()
        self.request = SmartyRequest()
        self.staticCredentials = StaticCredentials(authId: self.authId, authToken: self.authToken)
        self.sharedCredentials = SharedCredentials(id: self.authId, hostname: self.authToken)
    }
    
    override func tearDown() {
        super.tearDown()
        self.staticCredentials = nil
        self.sharedCredentials = nil
    }
    
    func testStaticCredentialsPopulated() {
        XCTAssertEqual(self.staticCredentials.authId, self.authId)
        XCTAssertEqual(self.staticCredentials.authToken, self.authToken)
    }
    
    func testStaticSignerFunction() {
        self.staticCredentials.sign(request: request)
        XCTAssertEqual(self.request.parameters["auth-id"], self.authId)
        XCTAssertEqual(self.request.parameters["auth-token"], self.authToken)
    }
    
    func testSharedCredentialsPopulated() {
        XCTAssertEqual(self.sharedCredentials.id, self.authId)
        XCTAssertEqual(self.sharedCredentials.hostname, self.authToken)
    }
    
    func testSharedSignerFunction() {
        self.sharedCredentials.sign(request: self.request)
        XCTAssertEqual(self.request.parameters["key"], self.authId)
        XCTAssertEqual(self.request.headers["Referer"], "https://\(self.authToken)")
    }
}
