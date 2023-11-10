import XCTest
@testable import SmartyStreets

class ClientBuilderTests: XCTestCase {
    
    var serializer:USZipCodeSerializer!
    
    override func setUp() {
        super.setUp()
        self.serializer = USZipCodeSerializer()
    }
    
    override func tearDown() {
        super.tearDown()
        self.serializer = nil
    }
    
    func testBasicInit() {
        let client = ClientBuilder()
        XCTAssertNotNil(client.serializer)
        XCTAssertEqual(client.maxRetries, 5)
        XCTAssertEqual(client.maxTimeout, 10000)
        XCTAssertEqual(client.debug, false)
        XCTAssertEqual(client.internationalStreetApiURL, "https://international-street.api.smarty.com/verify")
        XCTAssertEqual(client.internationalAutocompleteApiURL, "https://international-autocomplete.api.smarty.com/v2/lookup")
        XCTAssertEqual(client.usAutocompleteApiURL, "https://us-autocomplete.api.smarty.com/suggest")
        XCTAssertEqual(client.usExtractApiURL, "https://us-extract.api.smarty.com")
        XCTAssertEqual(client.usStreetApiURL, "https://us-street.api.smarty.com/street-address")
        XCTAssertEqual(client.usZipCodeApiURL, "https://us-zipcode.api.smarty.com/lookup")
    }
    
    func testInitWithSigner() {
        let signer = SmartyCredentials()
        let client = ClientBuilder(signer:signer)
        XCTAssertNotNil(client.signer)
    }
    
    func testInitWithAuthIdAndAuthToken() {
        let authID = "abc"
        let authToken = "123"
        let client = ClientBuilder(authId:authID, authToken:authToken)
        XCTAssertNotNil(client.signer)
    }
    
    func testRetryAtMost() {
        let client = ClientBuilder().retryAtMost(maxRetries:5)
        XCTAssertEqual(client.maxRetries, 5)
    }
    
    func testWithMaxTimeout() {
        let client = ClientBuilder().withMaxTimeout(maxTimeout: 20000)
        XCTAssertEqual(client.maxTimeout, 20000)
    }
    
    func testWithSender() {
        let sender = MockSender(response: nil)
        let client = ClientBuilder().withSender(sender:sender)
        XCTAssertNotNil(client.sender)
    }
    
    func testWithSerializer() {
        let serializer = USZipCodeSerializer()
        let client = ClientBuilder().withSerializer(serializer: serializer)
        XCTAssertNotNil(client.serializer)
    }
    
    func testWithUrl() {
        let url = "http://localhost/"
        let client = ClientBuilder().withUrl(urlPrefix:url)
        XCTAssertEqual(client.urlPrefix, url)
    }
    
    func testWithProxy() {
        let host = "localhost"
        let port = 8080
        let client = ClientBuilder().withProxy(host:host, port:port)
        XCTAssertNotNil(client.proxy[kCFNetworkProxiesHTTPEnable])
        XCTAssertNotNil(client.proxy[kCFNetworkProxiesHTTPPort])
        XCTAssertNotNil(client.proxy[kCFNetworkProxiesHTTPProxy])
    }
    
    func testWithDebug() {
        let client = ClientBuilder().withDebug()
        XCTAssertTrue(client.debug)
    }
    
    func testBuildSender() {
        let sender = ClientBuilder().withProxy(host: "localhost", port: 8080)
        XCTAssertNotNil(sender)
    }
    
    func testWithLicense() {
        let licenses = ["one", "two", "three"]
        let client = ClientBuilder().withLicenses(licenses: licenses)
        XCTAssertEqual(licenses, client.licenses)
    }
}
