import XCTest
@testable import SmartyStreets

class LanguageModeTests: XCTestCase {

    func testNativeConstants() {
        XCTAssertEqual("native", LanguageMode.Native)
    }

    func testLatinConstants() {
        XCTAssertEqual("latin", LanguageMode.Latin)
    }
}
