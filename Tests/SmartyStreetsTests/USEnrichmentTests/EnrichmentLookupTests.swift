import XCTest
@testable import SmartyStreets

class EnrichmentLookupTests: XCTestCase {

    func testRequestEtagDefaultEmpty() {
        let lookup = EnrichmentLookup()
        XCTAssertEqual("", lookup.getRequestEtag())
        XCTAssertEqual("", lookup.getResponseEtag())
    }

    func testSetEtagAliasesRequestEtag() {
        let lookup = EnrichmentLookup()
        lookup.setEtag(etag: "legacy-1")

        XCTAssertEqual("legacy-1", lookup.getRequestEtag())
        XCTAssertEqual("legacy-1", lookup.getEtag())
        XCTAssertEqual("", lookup.getResponseEtag())
    }

    func testSetRequestEtagVisibleThroughLegacyAlias() {
        let lookup = EnrichmentLookup()
        lookup.setRequestEtag(etag: "new-api")

        XCTAssertEqual("new-api", lookup.getEtag())
        XCTAssertEqual("new-api", lookup.getRequestEtag())
    }

    func testResponseEtagIndependentFromRequest() {
        let lookup = EnrichmentLookup()
        lookup.setRequestEtag(etag: "client-value")
        lookup.setResponseEtag(etag: "server-value")

        XCTAssertEqual("client-value", lookup.getRequestEtag())
        XCTAssertEqual("server-value", lookup.getResponseEtag())
    }

    func testBusinessNameDefaultsEmpty() {
        let lookup = EnrichmentLookup()
        XCTAssertEqual("", lookup.getBusinessName())
    }

    func testBusinessNameSurvivesBusinessSummaryCopy() {
        let lookup = EnrichmentLookup()
        lookup.setFreeform(freeform: "1 Rosedale, Baltimore, Maryland")
        lookup.setBusinessName(businessName: "school")

        let copy = BusinessSummaryEnrichmentLookup(lookup: lookup)

        XCTAssertEqual("school", copy.getBusinessName())
        XCTAssertEqual("1 Rosedale, Baltimore, Maryland", copy.getFreeform())
    }

    func testBusinessNameSurvivesOtherLookupCopies() {
        let lookup = EnrichmentLookup()
        lookup.setBusinessName(businessName: "school")

        XCTAssertEqual("school", PropertyPrincipalEnrichmentLookup(lookup: lookup).getBusinessName())
        XCTAssertEqual("school", GeoReferenceEnrichmentLookup(lookup: lookup).getBusinessName())
        XCTAssertEqual("school", SecondaryEnrichmentLookup(lookup: lookup).getBusinessName())
        XCTAssertEqual("school", SecondaryCountEnrichmentLookup(lookup: lookup).getBusinessName())
    }

    func testResponseEtagOmittedFromSerializedLookup() throws {
        let lookup = EnrichmentLookup(smartyKey: "xxx", datasetName: "property", dataSubsetName: "principal")
        lookup.setRequestEtag(etag: "request-value")
        lookup.setResponseEtag(etag: "should-not-appear")

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(lookup)
        let json = String(data: data, encoding: .utf8)!

        XCTAssertTrue(json.contains("\"etag\":\"request-value\""), "expected request etag in JSON, got: \(json)")
        XCTAssertFalse(json.contains("response_etag"), "response_etag must not appear in serialized lookup")
        XCTAssertFalse(json.contains("should-not-appear"), "response etag value must not appear in serialized lookup")
    }
}
