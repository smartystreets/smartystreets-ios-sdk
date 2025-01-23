import XCTest
@testable import SmartyStreets

class USZipCodeClientTests: XCTestCase {
    
    var sender:RequestCapturingSender!
    var serializer:USZipCodeSerializer!
    var batch:USZipCodeBatch!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.sender = RequestCapturingSender()
        self.serializer = USZipCodeSerializer()
        self.batch = USZipCodeBatch()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.sender = nil
        self.serializer = nil
        self.batch = nil
        self.error = nil
    }
    
    func testSendingSingleZipOnlyLookup() {
        let client = USZipCodeClient(sender:self.sender as Any, serializer:self.serializer)
        var lookup = USZipCodeLookup(city: String(), state: String(), zipcode: "1", inputId: "1")
        
        _ = client.sendLookup(lookup:&lookup, error:&self.error)
        
        let url = sender.request.getUrl()
        
        XCTAssertTrue(url.contains("input_id=1"))
        XCTAssertTrue(url.contains("zipcode=1"))
    }
    
    func testSendingSingleFullyPopulatedLookup() {
        let client = USZipCodeClient(sender: self.sender as Any, serializer: self.serializer)
        var lookup = USZipCodeLookup(city: "1", state: "2", zipcode: "3", inputId: "4")
        lookup.addCustomParameter(parameter: "custom", value: "5")
        
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        
        let url = sender.request.getUrl()
        XCTAssertTrue(url.contains("zipcode=3"))
        XCTAssertTrue(url.contains("state=2"))
        XCTAssertTrue(url.contains("city=1"))
        XCTAssertTrue(url.contains("custom=5"))
    }
    
    func testEmptyBatchNotSent() {
        let client = USZipCodeClient(sender: self.sender as Any, serializer: self.serializer)
        
        _ = client.sendBatch(batch: USZipCodeBatch(), error: &self.error)
        
        XCTAssertNil(self.sender.request)
    }
    
    func testSuccessfullySendsBatchOfLookups() {
        let client = USZipCodeClient(sender: self.sender as Any, serializer: self.serializer)
        
        _ = self.batch.add(newAddress: USZipCodeLookup(city: "123 North", state: "Pole", zipcode: String(), inputId: "1"), error: &self.error)
        _ = self.batch.add(newAddress: USZipCodeLookup(city: String(), state: String(), zipcode: "12345", inputId: "2"), error: &self.error)
        _ = client.sendBatch(batch: self.batch, error: &self.error)
        
        XCTAssertNotNil(sender.request.payload)
    }
}
