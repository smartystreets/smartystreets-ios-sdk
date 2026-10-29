import XCTest
@testable import SmartyStreets

class InternationalPostalCodeLanguageModeTests: XCTestCase {

    func testNativeConstants() {
        XCTAssertEqual("native", InternationalPostalCodeLanguageMode.Native)
    }

    func testLatinConstants() {
        XCTAssertEqual("latin", InternationalPostalCodeLanguageMode.Latin)
    }
}
