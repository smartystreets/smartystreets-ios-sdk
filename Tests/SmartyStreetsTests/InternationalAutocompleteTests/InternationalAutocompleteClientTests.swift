import XCTest
import SmartyStreets

class InternationalAutocompleteClientTests: XCTestCase {
    
    var capturingSender:RequestCapturingSender!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.capturingSender = RequestCapturingSender()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.capturingSender = nil
        self.error = nil
    }
    
    func testSendingSinglePrefixOnlyLookup() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: InternationalAutocompleteResult(dictionary: NSDictionary()))
        let client = InternationalAutocompleteClient(sender:sender, serializer:serializer)
        var lookup = InternationalAutocompleteLookup()
        lookup.search = "1"
        lookup.country = "2"
        lookup.locality = "3"
        lookup.maxResults = 4
        lookup.postalCode = "5"
        lookup.addressID = "6"
        lookup.addCustomParameter(parameter: "custom", value: "7")
        
        _ = client.sendLookup(lookup:&lookup, error:&error)
        
        XCTAssertEqual("1", capturingSender.request.parameters["search"])
        XCTAssertEqual("2", capturingSender.request.parameters["country"])
        XCTAssertEqual("3", capturingSender.request.parameters["include_only_locality"])
        XCTAssertEqual("4", capturingSender.request.parameters["max_results"])
        XCTAssertEqual("5", capturingSender.request.parameters["include_only_postal_code"])
        XCTAssertEqual("http://localhost/6", capturingSender.request.urlPrefix)
        XCTAssertEqual("7", capturingSender.request.parameters["custom"])
        XCTAssertNil(self.error)
    }

    func testSendingSingleMinimumParams() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: InternationalAutocompleteResult(dictionary: NSDictionary()))
        let client = InternationalAutocompleteClient(sender:sender, serializer:serializer)
        var lookup = InternationalAutocompleteLookup()
        lookup.search = "1"
        lookup.country = "2"
        
        _ = client.sendLookup(lookup:&lookup, error:&error)
        
        XCTAssertEqual("1", capturingSender.request.parameters["search"])
        XCTAssertEqual("2", capturingSender.request.parameters["country"])
        XCTAssertEqual(nil, capturingSender.request.parameters["include_only_locality"])
        XCTAssertEqual("10", capturingSender.request.parameters["max_results"])
        XCTAssertEqual(nil, capturingSender.request.parameters["include_only_postal_code"])
        XCTAssertNil(self.error)
    }
}
