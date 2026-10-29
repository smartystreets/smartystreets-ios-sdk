import XCTest
@testable import SmartyStreets

class InternationalPostalCodeClientTests: XCTestCase {
    
    var error:NSError!
    var capturingSender:RequestCapturingSender!
    var client:InternationalPostalCodeClient!
    var lookup:InternationalPostalCodeLookup!
    
    override func setUp() {
        super.setUp()
        self.error = nil
        self.capturingSender = RequestCapturingSender()
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: self.capturingSender)
        self.client = InternationalPostalCodeClient(sender: sender, serializer: InternationalPostalCodeSerializer())
        self.lookup = InternationalPostalCodeLookup()
        self.lookup.country = "CAN"
    }
    
    override func tearDown() {
        super.tearDown()
        self.error = nil
    }
    
    func send() {
        _ = self.client.sendLookup(lookup: &self.lookup, error: &self.error)
        XCTAssertNil(self.error)
    }
    
    func testLanguageSentWhenSet() {
        self.lookup.language = InternationalPostalCodeLanguageMode(name: InternationalPostalCodeLanguageMode.Latin)
        send()
        XCTAssertEqual("latin", self.capturingSender.request.parameters["language"])
    }
    
    func testLanguageLowercased() {
        self.lookup.language = InternationalPostalCodeLanguageMode(name: "NATIVE")
        send()
        XCTAssertEqual("native", self.capturingSender.request.parameters["language"])
    }
    
    func testLanguageOmittedWhenUnset() {
        send()
        XCTAssertNil(self.capturingSender.request.parameters["language"])
    }
    
    func testMaxResultsSentWhenSet() {
        self.lookup.maxResults = 25
        send()
        XCTAssertEqual("25", self.capturingSender.request.parameters["max_results"])
    }
    
    func testMaxResultsOmittedWhenUnset() {
        send()
        XCTAssertNil(self.capturingSender.request.parameters["max_results"])
    }
}
