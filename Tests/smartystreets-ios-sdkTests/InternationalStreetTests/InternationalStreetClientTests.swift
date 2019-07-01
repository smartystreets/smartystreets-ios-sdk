import XCTest
@testable import smartystreets_ios_sdk

class InternationalStreetClientTests: XCTestCase {
    
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.error = nil
    }
    
    func testSendingFreeformLookup() {
        let capturingSender = RequestCapturingSender()
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: capturingSender)
        let serializer = InternationalStreetSerializer()
        let client = InternationalStreetClient(sender: sender, serializer: serializer)
        var lookup = InternationalStreetLookup(freeform:"freeform", country:"USA", inputId: nil)
        
        _ = client.sendLookup(lookup:&lookup, error:&self.error)
        
        let url = capturingSender.request.getUrl()
        
        XCTAssertNil(self.error)
        XCTAssertTrue(url.contains("http://localhost/?"))
        XCTAssertTrue(url.contains("country=USA"))
        XCTAssertTrue(url.contains("freeform=freeform"))
    }
    
    func testSendingSingleFullyPopulatedLookup() {
        let capturingSender = RequestCapturingSender()
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: capturingSender)
        let serializer = InternationalStreetSerializer()
        let client = InternationalStreetClient(sender: sender, serializer: serializer)
        var lookup = InternationalStreetLookup(freeform: "freeform", country: "USA", inputId: nil)
        
        lookup.country = "0"
        lookup.enableGeocode(geocode: true)
        lookup.language = LanguageMode(name: "native")
        lookup.freeform = "1"
        lookup.address1 = "2"
        lookup.address2 = "3"
        lookup.address3 = "4"
        lookup.address4 = "5"
        lookup.organization = "6"
        lookup.locality = "7"
        lookup.administrativeArea = "8"
        lookup.postalCode = "9"
        
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        
        XCTAssertNil(self.error)
        XCTAssertNotNil(capturingSender.request.getUrl())
    }
}
