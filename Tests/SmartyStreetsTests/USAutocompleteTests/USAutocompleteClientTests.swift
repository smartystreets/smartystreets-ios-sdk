import XCTest
@testable import SmartyStreets

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

    func testSendingSearchOnlyLookup() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: USAutocompleteResult(dictionary: NSDictionary()))
        let client = USAutocompleteClient(sender:sender, serializer:serializer)
        var lookup = USAutocompleteLookup().withSearch(search: "1")

        _ = client.sendLookup(lookup:&lookup, error:&error)

        XCTAssertEqual("1", capturingSender.request.parameters["search"])
        XCTAssertEqual("city", capturingSender.request.parameters["prefer_geolocation"])
        XCTAssertNil(self.error)
    }

    func testSendingFullyPopulatedLookup() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: USAutocompleteResult(dictionary: NSDictionary()))
        let client = USAutocompleteClient(sender:sender, serializer:serializer)
        var lookup = USAutocompleteLookup().withSearch(search: "1")
        lookup.selected = "selectedAddress"
        lookup.addExclude(exclude: "excludedAddress")
        lookup.maxResults = 5
        lookup.addCityFilter(city: "city")
        lookup.addStateFilter(state: "state")
        lookup.excludeStates?.append("excludedState")
        lookup.addPreferCity(city: "preferCity")
        lookup.addPreferState(state: "preferState")
        lookup.preferRatio = 4
        lookup.source = .all
        lookup.addCustomParameter(parameter: "custom", value: "7")

        _ = client.sendLookup(lookup:&lookup, error:&error)

        XCTAssertEqual("1", capturingSender.request.parameters["search"])
        XCTAssertEqual("selectedAddress", capturingSender.request.parameters["selected"])
        XCTAssertEqual("excludedAddress", capturingSender.request.parameters["exclude"])
        XCTAssertEqual("5", capturingSender.request.parameters["max_results"])
        XCTAssertEqual("city", capturingSender.request.parameters["include_only_cities"])
        XCTAssertEqual("state", capturingSender.request.parameters["include_only_states"])
        XCTAssertEqual("excludedState", capturingSender.request.parameters["exclude_states"])
        XCTAssertEqual("preferCity", capturingSender.request.parameters["prefer_cities"])
        XCTAssertEqual("preferState", capturingSender.request.parameters["prefer_states"])
        XCTAssertEqual("4", capturingSender.request.parameters["prefer_ratio"])
        XCTAssertEqual("all", capturingSender.request.parameters["source"])
        XCTAssertEqual("7", capturingSender.request.parameters["custom"])
        XCTAssertNil(self.error)
    }

    func testSourceAllIsSetInRequest() {
        let client = USAutocompleteClient(sender: RequestCapturingSender(), serializer: MockSerializer())
        let lookup = USAutocompleteLookup()
        lookup.source = .all
        let request = client.buildRequest(lookup: lookup)
        XCTAssertEqual(request.parameters["source"], "all")
    }

    func testSourcePostalIsSetInRequest() {
        let client = USAutocompleteClient(sender: RequestCapturingSender(), serializer: MockSerializer())
        let lookup = USAutocompleteLookup()
        lookup.source = .postal
        let request = client.buildRequest(lookup: lookup)
        XCTAssertEqual(request.parameters["source"], "postal")
    }

    func testSourceNotInRequestWhenNotSet() {
        let client = USAutocompleteClient(sender: RequestCapturingSender(), serializer: MockSerializer())
        let lookup = USAutocompleteLookup()
        let request = client.buildRequest(lookup: lookup)
        XCTAssertNil(request.parameters["source"])
    }

    func testSendingExclude() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: USAutocompleteResult(dictionary: NSDictionary()))
        let client = USAutocompleteClient(sender:sender, serializer:serializer)
        var lookup = USAutocompleteLookup().withSearch(search: "1")
        lookup.exclude = ["excludedAddress", "excludeAddress2"]

        _ = client.sendLookup(lookup:&lookup, error:&error)

        XCTAssertEqual("excludedAddress,excludeAddress2", capturingSender.request.parameters["exclude"])
        XCTAssertNil(self.error)
    }

    func testUrbanizationDeserializedFromResponse() {
        let dictionary: NSDictionary = [
            "suggestions": [
                ["urbanization": "urb", "street_line": "1", "entry_id": "2"],
                ["street_line": "3", "entry_id": "4"]
            ]
        ]

        let result = USAutocompleteResult(dictionary: dictionary)

        XCTAssertEqual("urb", result.getSuggestionAtIndex(index: 0).urbanization)
        XCTAssertNil(result.getSuggestionAtIndex(index: 1).urbanization)
    }
}
