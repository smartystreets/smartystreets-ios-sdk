import XCTest
@testable import SmartyStreets

class USAutocompleteResultTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllFieldsGetFilledInCorrectly() {
        let object:NSDictionary = ["suggestions":[["text":"1","street_line":"2","city":"3","state":"4"]]]
        let result = USAutocompleteResult(dictionary:object)
        
        let suggestion = result.getSuggestionAtIndex(index: 0)
        
        XCTAssertEqual(suggestion.text, "1")
        XCTAssertEqual(suggestion.streetLine, "2")
        XCTAssertEqual(suggestion.city, "3")
        XCTAssertEqual(suggestion.state, "4")
    }
}
