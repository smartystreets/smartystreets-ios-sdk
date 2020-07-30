import XCTest
@testable import SmartyStreets

class SmartyRequestTests: XCTestCase {
    var smartyRequest:SmartyRequest!
    
    override func setUp() {
        super.setUp()
        self.smartyRequest = SmartyRequest()
    }
    
    override func tearDown() {
        super.tearDown()
        self.smartyRequest = nil
    }
    
    func testInitialize() {
        XCTAssertEqual(smartyRequest.headers, [:])
        XCTAssertEqual(smartyRequest.parameters, [:])
        XCTAssertEqual(smartyRequest.urlPrefix, "")
        XCTAssertEqual(smartyRequest.method, "GET")
        XCTAssertEqual(smartyRequest.contentType, "application/json")
    }
    
    func testSetHeaderFieldValue() {
        let name = "header"
        let value = "value"
        smartyRequest.setValue(value: value, HTTPHeaderField: name)
        XCTAssertEqual(smartyRequest.headers, ["header":"value"])
    }
    
    
    func testSetParameterFieldValue() {
        let name = "parameter"
        let value = "value"
        smartyRequest.setValue(value: value, HTTPParameterField: name)
        XCTAssertEqual(smartyRequest.parameters, ["parameter":"value"])
    }
    
    func testGetURL() {
        smartyRequest.urlPrefix = "https://fakesearch.com/lookup?"
        smartyRequest.setValue(value: "Parks Blvd", HTTPParameterField: "street")
        let url = smartyRequest.getUrl()
        XCTAssertEqual(url, "https://fakesearch.com/lookup?street=Parks+Blvd")
    }
    
}
