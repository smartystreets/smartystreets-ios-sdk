import XCTest
import sdk

class USStreetClientTests: XCTestCase {
    
    var serializer:USStreetSerializer!
    var client:USStreetClient!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.serializer = USStreetSerializer()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.serializer = nil
        self.error = nil
    }
    
    func testSendingSingleFreeformLookup() {
        let expectedUrl = "http://localhost/?street=freeform"
        let sender = RequestCapturingSender()
        let client = USStreetClient(sender: sender, serializer: serializer)
        
        var lookup = USStreetLookup(freeformAddress: "freeform")
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        
        let actualUrl = sender.request.getUrl()
        
        XCTAssertEqual(actualUrl, expectedUrl)
    }
    
    func testSendingSingleFullyPopulatedLookup() {
        let capturingSender = RequestCapturingSender()
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: capturingSender)
        let client = USStreetClient(sender: sender, serializer: serializer)
        var lookup = USStreetLookup()
        
        lookup.addressee = "0"
        lookup.street = "1"
        lookup.secondary = "2"
        lookup.street2 = "3"
        lookup.urbanization = "4"
        lookup.city = "5"
        lookup.state = "6"
        lookup.zipCode = "7"
        lookup.lastline = "8"
        lookup.setMaxCandidates(max: 9, error: &self.error)
        XCTAssertNil(self.error)
        
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        XCTAssertNil(self.error)
        XCTAssertNotNil(capturingSender.request.getUrl())
    }
    
    func testEmptyBatchNotSent() {
        let sender = RequestCapturingSender()
        let client = USStreetClient(sender: sender, serializer: serializer)
        
        _ = client.sendBatch(batch: USStreetBatch(), error: &self.error)
        XCTAssertNil(sender.request)
    }
}
