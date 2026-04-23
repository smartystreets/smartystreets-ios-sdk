import XCTest
@testable import SmartyStreets

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

    func testHeadersDefaultToEmpty() {
        let response = SmartyResponse(statusCode: 200, payload: Data())
        XCTAssertTrue(response.headers.isEmpty)
    }

    func testHeadersRoundTripThroughInit() {
        let headers = ["Etag": "abc-123", "Content-Type": "application/json"]
        let response = SmartyResponse(statusCode: 200, payload: Data(), headers: headers)
        XCTAssertEqual(response.headers["Etag"], "abc-123")
        XCTAssertEqual(response.headers["Content-Type"], "application/json")
    }
}
