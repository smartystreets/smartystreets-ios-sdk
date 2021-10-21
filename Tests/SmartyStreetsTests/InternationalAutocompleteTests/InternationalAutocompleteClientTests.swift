import XCTest
@testable import SmartyStreets

class InternationalAutocompleteClientTests: XCTestCase {
    
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.error = nil
    }
    
    func testSendingLookup() {
        let capturingSender = RequestCapturingSender()
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: capturingSender)
        let serializer = InternationalAutocompleteSerializer()
        let client = InternationalAutocompleteClient(sender: sender, serializer: serializer)
        var lookup = InternationalAutocompleteLookup()
        lookup.country = "FRA"
        lookup.search = "Louis"
        
        _ = client.sendLookup(lookup:&lookup, error:&self.error)
        
        let url = capturingSender.request.getUrl()
        
        XCTAssertNil(self.error)
        XCTAssertTrue(url.contains("http://localhost/?"))
        XCTAssertTrue(url.contains("country=FRA"))
        XCTAssertTrue(url.contains("search=Louis"))
    }
}
