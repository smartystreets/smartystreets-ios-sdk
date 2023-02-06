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
                    "super_administrative_area":"3",
                    "sub_administrative_area":"4",
                    "postal_code":"5",
                    "country_iso3":"6"
                ],
                [
                    "street":"7",
                    "locality":"8",
                    "administrative_area":"9",
                    "super_administrative_area":"super",
                    "sub_administrative_area":"sub",
                    "postal_code":"10",
                    "country_iso3":"11"
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
        XCTAssertEqual("3", result.getCandidateAtIndex(index: 0).superAdministrativeArea)
        XCTAssertEqual("4", result.getCandidateAtIndex(index: 0).subAdministrativeArea)
        XCTAssertEqual("5", result.getCandidateAtIndex(index: 0).postalCode)
        XCTAssertEqual("6", result.getCandidateAtIndex(index: 0).countryISO3)
        
        XCTAssertEqual("7", result.getCandidateAtIndex(index: 1).street)
        XCTAssertEqual("8", result.getCandidateAtIndex(index: 1).locality)
        XCTAssertEqual("9", result.getCandidateAtIndex(index: 1).administrativeArea)
        XCTAssertEqual("super", result.getCandidateAtIndex(index: 1).superAdministrativeArea)
        XCTAssertEqual("sub", result.getCandidateAtIndex(index: 1).subAdministrativeArea)
        XCTAssertEqual("10", result.getCandidateAtIndex(index: 1).postalCode)
        XCTAssertEqual("11", result.getCandidateAtIndex(index: 1).countryISO3)
    }
}
