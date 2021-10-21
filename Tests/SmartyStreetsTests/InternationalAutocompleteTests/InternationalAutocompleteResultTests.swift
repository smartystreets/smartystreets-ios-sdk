import XCTest
@testable import SmartyStreets

class InternationalAutocompleteResultTests: XCTestCase {
    
    var obj:NSDictionary!
    
    override func setUp() {
        super.setUp()
        self.obj = [
            "candidates": [
                [
                    "street":"0",
                    "locality":"1",
                    "administrative_area":"2",
                    "postal_code":"3",
                    "country_iso3":"4"
                ],
                [
                    "street":"5",
                    "locality":"6",
                    "administrative_area":"7",
                    "postal_code":"8",
                    "country_iso3":"9"
                ]
            ]
        ]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllFieldsFilledCorrectly() {
        let result = InternationalAutocompleteResult(dictionary: obj)
        
        XCTAssertEqual("0", result.getCandidateAtIndex(index: 0).street)
        XCTAssertEqual("1", result.getCandidateAtIndex(index: 0).locality)
        XCTAssertEqual("2", result.getCandidateAtIndex(index: 0).administrativeArea)
        XCTAssertEqual("3", result.getCandidateAtIndex(index: 0).postalCode)
        XCTAssertEqual("4", result.getCandidateAtIndex(index: 0).countryISO3)
        
        XCTAssertEqual("5", result.getCandidateAtIndex(index: 1).street)
        XCTAssertEqual("6", result.getCandidateAtIndex(index: 1).locality)
        XCTAssertEqual("7", result.getCandidateAtIndex(index: 1).administrativeArea)
        XCTAssertEqual("8", result.getCandidateAtIndex(index: 1).postalCode)
        XCTAssertEqual("9", result.getCandidateAtIndex(index: 1).countryISO3)
    }
}
