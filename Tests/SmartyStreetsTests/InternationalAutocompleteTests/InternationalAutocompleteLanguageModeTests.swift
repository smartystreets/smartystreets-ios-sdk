import XCTest
@testable import SmartyStreets

class InternationalAutocompleteLanguageModeTests: XCTestCase {

    func testNativeConstants() {
        XCTAssertEqual("native", InternationalAutocompleteLanguageMode.Native)
    }

    func testLatinConstants() {
        XCTAssertEqual("latin", InternationalAutocompleteLanguageMode.Latin)
    }
}
