import XCTest
import sdk

class USAutocompleteClientTests: XCTestCase {
    
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
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: USAutocompleteResult(dictionary: NSDictionary()))
        let client = USAutocompleteClient(sender:sender, serializer:serializer)
        var lookup = USAutocompleteLookup().withPrefix(prefix:"1")
        
        _ = client.sendLookup(lookup:&lookup, error:&error)
        
        XCTAssertEqual("1", capturingSender.request.parameters["prefix"])
        XCTAssertEqual("city", capturingSender.request.parameters["geolocate_precision"])
        XCTAssertEqual("true", capturingSender.request.parameters["geolocate"])
        XCTAssertNil(capturingSender.request.parameters["suggestions"])
        XCTAssertNil(capturingSender.request.parameters["prefer_ratio"])
        XCTAssertNil(self.error)
    }
    
    func testsSendingSingleFullyPopulatedLookup() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: USAutocompleteResult(dictionary: NSDictionary()))
        let client = USAutocompleteClient(sender: sender, serializer: serializer)
        
        var lookup = USAutocompleteLookup()
        lookup.prefix = "1"
        lookup.setMaxSuggestions(maxSuggestions: 2, error: &error)
        lookup.addCityFilter(city: "3")
        lookup.addStateFilter(state: "4")
        lookup.addPrefer(cityORstate: "5")
        lookup.preferRatio = 0.6
        lookup.geolocateType = GeolocateType(name: "state")
        
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        
        XCTAssertEqual("1", capturingSender.request.parameters["prefix"])
        XCTAssertEqual("2", capturingSender.request.parameters["suggestions"])
        XCTAssertEqual("3", capturingSender.request.parameters["city_filter"])
        XCTAssertEqual("true", capturingSender.request.parameters["geolocate"])
        XCTAssertEqual("state", capturingSender.request.parameters["geolocate_precision"])
        XCTAssertEqual("4", capturingSender.request.parameters["state_filter"])
        XCTAssertEqual("5", capturingSender.request.parameters["prefer"])
        XCTAssertEqual("0.6", capturingSender.request.parameters["prefer_ratio"])
        XCTAssertNil(self.error)
    }
    
    func testSendingLookupWithGeolocateTypeSetToNone() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: USAutocompleteResult(dictionary: NSDictionary()))
        let client = USAutocompleteClient(sender: sender, serializer: serializer)
        
        var lookup = USAutocompleteLookup().withPrefix(prefix: "1")
        lookup.geolocateType = GeolocateType(name: "none")
        
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        
        XCTAssertEqual("false", capturingSender.request.parameters["geolocate"])
        XCTAssertNil(self.error)
    }
}
