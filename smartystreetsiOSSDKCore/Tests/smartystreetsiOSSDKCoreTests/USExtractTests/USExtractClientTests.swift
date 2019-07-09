import XCTest
@testable import smartystreetsiOSSDKCore

class USExtractClientTests: XCTestCase {
    
    var capturingSender:RequestCapturingSender!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.capturingSender = RequestCapturingSender()
        self.error  = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.capturingSender = nil
    }
    
    func testSendingBodyOnlyLookup() {
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: self.capturingSender as Any)
        let serializer = MockSerializer(result: NSDictionary())
        let client = USExtractClient(sender: sender, serializer: serializer)
        let helloWorld = "Hello, World!"
        let expectedPayload = helloWorld.data(using: .utf8)
        var lookup = USExtractLookup().withText(text: helloWorld)
        
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        
        XCTAssertNotNil(capturingSender.request)
        if let request = capturingSender.request {
            let parameters = request.parameters
            XCTAssertNil(self.error)
            XCTAssertEqual(parameters["aggressive"], "false")
            XCTAssertEqual(parameters["addr_line_breaks"], "true")
            XCTAssertEqual(parameters["addr_per_line"], "0")
            XCTAssertEqual(capturingSender.request.payload, expectedPayload)
        }
    }
}
