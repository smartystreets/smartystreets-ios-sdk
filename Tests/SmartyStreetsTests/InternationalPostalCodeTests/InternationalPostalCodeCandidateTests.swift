import XCTest
@testable import SmartyStreets

class InternationalPostalCodeCandidateTests: XCTestCase {
    
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.error = nil
    }
    
    func testThoroughfareDecodedFromPayload() {
        let payload = "[{\"thoroughfare\":\"8\"}]".data(using: .utf8)
        
        let candidates = InternationalPostalCodeSerializer().Deserialize(payload: payload, error: &self.error) as? [InternationalPostalCodeCandidate]
        
        XCTAssertNil(self.error)
        XCTAssertEqual("8", candidates?[0].thoroughfare)
    }
    
    func testThoroughfareFromDictionary() {
        let candidate = InternationalPostalCodeCandidate(dictionary: ["thoroughfare": "8"])
        
        XCTAssertEqual("8", candidate.thoroughfare)
    }
}
