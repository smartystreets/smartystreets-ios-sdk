import XCTest
@testable import SmartyStreets

class USReverseGeoClientTests: XCTestCase {
    
    var expectedJsonInput:String!
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
        let serializer = USReverseGeoSerializer()
        let client = USReverseGeoClient(sender: sender, serializer: serializer)
        var lookup = USReverseGeoLookup(latitude: 44.888888888, longitude: -111.111111111)

        _ = client.sendLookup(lookup:&lookup, error:&self.error)

        let url = capturingSender.request.getUrl()

        XCTAssertTrue(url.contains("http://localhost/?"))
        XCTAssertTrue(url.contains("latitude=44.88888889"))
        XCTAssertTrue(url.contains("longitude=-111.11111111"))
    }

    func testSourceAllIsSetInRequest() {
        let client = USReverseGeoClient(sender: RequestCapturingSender(), serializer: USReverseGeoSerializer())
        let request = client.buildRequest(lookup: USReverseGeoLookup(latitude: 44.0, longitude: -111.0, source: .all))
        XCTAssertEqual(request.parameters["source"], "all")
    }

    func testSourcePostalIsSetInRequest() {
        let client = USReverseGeoClient(sender: RequestCapturingSender(), serializer: USReverseGeoSerializer())
        let request = client.buildRequest(lookup: USReverseGeoLookup(latitude: 44.0, longitude: -111.0, source: .postal))
        XCTAssertEqual(request.parameters["source"], "postal")
    }

    func testSourceNotInRequestWhenNotSet() {
        let client = USReverseGeoClient(sender: RequestCapturingSender(), serializer: USReverseGeoSerializer())
        let request = client.buildRequest(lookup: USReverseGeoLookup(latitude: 44.0, longitude: -111.0))
        XCTAssertNil(request.parameters["source"])
    }
}
