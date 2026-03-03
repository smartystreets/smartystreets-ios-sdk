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
        XCTAssertEqual(client.internationalPostalCodeApiURL, "https://international-postal-code.api.smarty.com/lookup")
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

    func testWithCustomQuery() {
        let queries = ["test":"result","other":"different"]
        let client = ClientBuilder()
            .withCustomQuery(key: "test", value: "result")
            .withCustomQuery(key: "other", value: "different")
        XCTAssertEqual(queries, client.queries)
    }

    func testWithCustomCommaSeparatedQuery() {
        let queries = [
            "test":"result,contains,commas", 
            "other":"has,more,commas"
        ]
        let client = ClientBuilder()
            .withCustomCommaSeparatedQuery(key: "test", value: "result")
            .withCustomCommaSeparatedQuery(key: "test", value: "contains")
            .withCustomCommaSeparatedQuery(key: "test", value: "commas")
            .withCustomCommaSeparatedQuery(key: "other", value: "has")
            .withCustomCommaSeparatedQuery(key: "other", value: "more")
            .withCustomCommaSeparatedQuery(key: "other", value: "commas")

        XCTAssertEqual(queries, client.queries)
    }

    func testWithFeaturesComponentAnalysis() {
        let queries = ["features":"component-analysis"]
        let client = ClientBuilder().withFeatureComponentAnalysis()
        XCTAssertEqual(queries, client.queries)
    }

    func testWithFeatureIANATimeZone() {
        let queries = ["features":"iana-timezone"]
        let client = ClientBuilder().withFeatureIANATimeZone()
        XCTAssertEqual(queries, client.queries)
    }

    func testWithFeatureIANATimeZoneAndComponentAnalysis_ShouldAppend() {
        let queries = ["features":"component-analysis,iana-timezone"]
        let client = ClientBuilder()
            .withFeatureComponentAnalysis()
            .withFeatureIANATimeZone()
        XCTAssertEqual(queries, client.queries)
    }

    func testWithCustomHeader() {
        let client = ClientBuilder().withCustomHeader(key: "X-Custom", value: "test-value")
        XCTAssertEqual("test-value", client.headers["X-Custom"])
    }

    func testWithCustomHeaderUserAgentAppends() {
        let version = Version().version
        let client = ClientBuilder().withCustomHeader(key: "User-Agent", value: "my-app/1.0")
        XCTAssertEqual("smartystreets (sdk:ios@\(version)) my-app/1.0", client.headers["User-Agent"])
    }

    func testWithCustomHeaderUserAgentAppendsMultiple() {
        let version = Version().version
        let client = ClientBuilder()
            .withCustomHeader(key: "User-Agent", value: "my-app/1.0")
            .withCustomHeader(key: "User-Agent", value: "my-lib/2.0")
        XCTAssertEqual("smartystreets (sdk:ios@\(version)) my-app/1.0 my-lib/2.0", client.headers["User-Agent"])
    }

    func testBuildHeadersIncludesDefaultUserAgent() {
        let version = Version().version
        let client = ClientBuilder()
        let headers = client.buildHeaders()
        XCTAssertEqual("smartystreets (sdk:ios@\(version))", headers["User-Agent"])
    }

    func testBuildHeadersPreservesCustomUserAgent() {
        let version = Version().version
        let client = ClientBuilder().withCustomHeader(key: "User-Agent", value: "my-app/1.0")
        let headers = client.buildHeaders()
        XCTAssertEqual("smartystreets (sdk:ios@\(version)) my-app/1.0", headers["User-Agent"])
    }
}
