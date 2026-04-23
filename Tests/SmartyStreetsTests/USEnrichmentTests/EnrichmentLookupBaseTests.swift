import XCTest
@testable import SmartyStreets

class EnrichmentLookupBaseTests: XCTestCase {

    func testEnrichmentLookupInheritsFromBase() {
        let lookup: EnrichmentLookupBase = EnrichmentLookup()
        XCTAssertTrue(lookup is EnrichmentLookup)
    }

    func testSharedFieldsReadableThroughBase() {
        let lookup = EnrichmentLookup()
        lookup.addIncludeAttribute(attribute: "phone")
        lookup.addExcludeAttribute(attribute: "credit_score")
        lookup.setRequestEtag(etag: "abc")
        lookup.addCustomParameter(parameter: "trace", value: "on")

        let base: EnrichmentLookupBase = lookup
        XCTAssertEqual(["phone"], base.getIncludeAttributes())
        XCTAssertEqual(["credit_score"], base.getExcludeAttributes())
        XCTAssertEqual("abc", base.getRequestEtag())
        XCTAssertEqual("on", base.getCustomParamArray()["trace"])
    }
}
