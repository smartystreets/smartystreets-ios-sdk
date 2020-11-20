import XCTest
@testable import SmartyStreets

class USReverseGeoTests: XCTestCase {
    
    var obj:NSDictionary!
    
    override func setUp() {
        super.setUp()
        self.obj = ["results": [
                [
                    "coordinate": [
                        "latitude": 1.1,
                        "longitude": -2.2,
                        "accuracy": "3",
                        "license": 4
                    ],
                    "distance": 5,
                    "address": [
                        "street": "6",
                        "city": "7",
                        "state_abbreviation": "8",
                        "zipcode": "9"
                    ]
                ],
            ]
        ]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllFieldsFilledCorrectly() {
        let response = USReverseGeoResponse(dictionary: obj)
        if let result = response.results?[0] {
            XCTAssertEqual(5, result.distance)
            
            if let coordinate = result.coordinate {
                XCTAssertEqual(1.1, coordinate.latitude)
                XCTAssertEqual(-2.2, coordinate.longitude)
                XCTAssertEqual("3", coordinate.accuracy)
                XCTAssertEqual("SmartyStreets", coordinate.getLicense())
            }
            
            if let address = result.address {
                XCTAssertEqual("6", address.street)
                XCTAssertEqual("7", address.city)
                XCTAssertEqual("8", address.stateAbbreviation)
                XCTAssertEqual("9", address.zipcode)
            }
        }
    }
}
