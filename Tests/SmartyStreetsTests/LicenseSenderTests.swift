import XCTest
@testable import SmartyStreets

class LicenseSenderTests: XCTestCase {
    
    var request:SmartyRequest!
    var mockSender:MockSender!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.request = SmartyRequest()
        self.mockSender = MockSender()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.request = nil
        self.mockSender = nil
        self.error = nil
    }
    
    func testLicenseParameterSet() {
        let licenses = ["one", "two", "three"]
        let licenseSender = LicenseSender(licenses: licenses, inner: self.mockSender!)
        let _ = licenseSender.sendRequest(request: self.request!, error: &self.error)
        XCTAssertEqual("one,two,three", self.mockSender.request.parameters["license"])
    }
    
    func testLicenseParameterNotSet() {
        let licenseSender = LicenseSender(licenses: nil, inner: self.mockSender!)
        let _ = licenseSender.sendRequest(request: self.request!, error: &self.error)
        XCTAssertEqual(0, self.mockSender.request.parameters.count)
    }
}
