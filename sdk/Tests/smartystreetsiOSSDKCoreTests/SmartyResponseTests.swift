import XCTest
@testable import sdk

class SmartyResponseTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testInit() {
        let payload = Data(count: 5)
        let response = SmartyResponse(statusCode:200, payload: payload)
        XCTAssertEqual(response.statusCode, 200)
        XCTAssertEqual(response.payload.count, 5)
    }
}
