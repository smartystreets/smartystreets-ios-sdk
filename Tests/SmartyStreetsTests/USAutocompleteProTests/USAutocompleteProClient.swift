import XCTest
@testable import SmartyStreets

class USAutocompleteProClientTests: XCTestCase {

    func testSourceAllIsSetInRequest() {
        let client = USAutocompleteProClient(sender: RequestCapturingSender(), serializer: MockSerializer())
        let lookup = USAutocompleteProLookup()
        lookup.source = .all
        let request = client.buildRequest(lookup: lookup)
        XCTAssertEqual(request.parameters["source"], "all")
    }

    func testSourcePostalIsSetInRequest() {
        let client = USAutocompleteProClient(sender: RequestCapturingSender(), serializer: MockSerializer())
        let lookup = USAutocompleteProLookup()
        lookup.source = .postal
        let request = client.buildRequest(lookup: lookup)
        XCTAssertEqual(request.parameters["source"], "postal")
    }

    func testSourceNotInRequestWhenNotSet() {
        let client = USAutocompleteProClient(sender: RequestCapturingSender(), serializer: MockSerializer())
        let lookup = USAutocompleteProLookup()
        let request = client.buildRequest(lookup: lookup)
        XCTAssertNil(request.parameters["source"])
    }
}
