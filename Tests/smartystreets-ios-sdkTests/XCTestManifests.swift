import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(smartystreets_ios_sdkTests.allTests),
    ]
}
#endif
