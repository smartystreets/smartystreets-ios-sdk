import XCTest
@testable import smartystreetsiOSSDKCore

class USExtractResultTests: XCTestCase {
    
    var obj:[String:Any] = ["meta":
        ["lines":1,
         "unicode":true,
         "address_count":2,
         "verified_count":3,
         "bytes":4,
         "character_count":5],
                            "addresses":
                                [["text":"6",
                                  "verified":true,
                                  "line":7,
                                  "start":8,
                                  "end":9,
                                  "api_output":[USStreetCandidate]()],
                                 ["text":"10"]
        ]]
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testAllFieldsFilledCorrectly() {
        let result = USExtractResult(dictionary:obj as NSDictionary)
        
        let metadata = result.metadata
        XCTAssertNotNil(metadata)
        XCTAssertEqual(metadata?.lines, 1)
        XCTAssertTrue((metadata?.isUnicode())!)
        XCTAssertEqual(metadata?.addressCount, 2)
        XCTAssertEqual(metadata?.verifiedCount, 3)
        XCTAssertEqual(metadata?.bytes, 4)
        XCTAssertEqual(metadata?.characterCount, 5)
        
        let address = result.getAddressAtIndex(index:0)
        XCTAssertNotNil(address)
        XCTAssertEqual(address.text, "6")
        XCTAssertTrue(address.isVerified())
        XCTAssertEqual(address.line, 7)
        XCTAssertEqual(address.start, 8)
        XCTAssertEqual(address.end, 9)
        XCTAssertEqual(result.getAddressAtIndex(index: 1).text, "10")
        XCTAssertNotNil(address.candidates)
    }
}
