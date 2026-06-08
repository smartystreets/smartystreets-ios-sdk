import XCTest
@testable import SmartyStreets

class USEnrichmentClientTests: XCTestCase {

    private var error: NSError!

    override func setUp() {
        super.setUp()
        self.error = nil
    }

    override func tearDown() {
        super.tearDown()
        self.error = nil
    }

    // Builds a client that captures the outgoing SmartyRequest and returns an empty-array payload
    // with optional headers on the response.
    private func capturingClient(responseHeaders: [String:String] = [:]) -> (client: USEnrichmentClient, sender: CapturingSender) {
        let sender = CapturingSender(responseHeaders: responseHeaders)
        let client = USEnrichmentClient(sender: sender)
        return (client, sender)
    }

    // MARK: - Business summary URL shape

    func testBusinessSummaryBySmartyKeyUrl() {
        let (client, sender) = capturingClient()
        _ = client.sendBusinessLookup(smartyKey: "1", error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/1/business", sender.request.urlComponents)
        XCTAssertTrue(sender.request.parameters.isEmpty)
    }

    func testBusinessSummaryByComponentsUrl() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()
        lookup.setStreet(street: "street")
        lookup.setCity(city: "city")
        lookup.setState(state: "state")
        lookup.setZipcode(zipcode: "zipcode")

        _ = client.sendBusinessLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/search/business", sender.request.urlComponents)
        XCTAssertEqual("street", sender.request.parameters["street"])
        XCTAssertEqual("city", sender.request.parameters["city"])
        XCTAssertEqual("state", sender.request.parameters["state"])
        XCTAssertEqual("zipcode", sender.request.parameters["zipcode"])
    }

    func testBusinessSummaryByFreeformUrl() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()
        lookup.setFreeform(freeform: "freeform")

        _ = client.sendBusinessLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/search/business", sender.request.urlComponents)
        XCTAssertEqual("freeform", sender.request.parameters["freeform"])
    }

    func testBusinessSummarySearchSetsBusinessNameParameter() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()
        lookup.setFreeform(freeform: "1 Rosedale, Baltimore, Maryland")
        lookup.setBusinessName(businessName: "school")

        _ = client.sendBusinessLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/search/business", sender.request.urlComponents)
        XCTAssertEqual("1 Rosedale, Baltimore, Maryland", sender.request.parameters["freeform"])
        XCTAssertEqual("school", sender.request.parameters["business_name"])
    }

    func testBusinessSummarySearchOmitsEmptyBusinessName() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()
        lookup.setFreeform(freeform: "1 Rosedale, Baltimore, Maryland")

        _ = client.sendBusinessLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/search/business", sender.request.urlComponents)
        XCTAssertNil(sender.request.parameters["business_name"])
    }

    // MARK: - Business detail URL shape

    func testBusinessDetailUrlContainsBusinessId() {
        let (client, sender) = capturingClient()
        _ = client.sendBusinessDetailLookup(businessId: "ABC123", error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/business/ABC123", sender.request.urlComponents)
        XCTAssertTrue(sender.request.parameters.isEmpty)
    }

    func testBusinessDetailUrlEncodesReservedChars() {
        let (client, sender) = capturingClient()
        _ = client.sendBusinessDetailLookup(businessId: "a/b?c#d", error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/business/a%2Fb%3Fc%23d", sender.request.urlComponents)
    }

    func testBusinessDetailUrlEncodesSpaces() {
        let (client, sender) = capturingClient()
        _ = client.sendBusinessDetailLookup(businessId: "Acme Corp", error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("/business/Acme%20Corp", sender.request.urlComponents)
    }

    // MARK: - Common parameters applied to detail

    func testBusinessDetailSendsRequestEtagHeader() {
        let (client, sender) = capturingClient()
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC123")
        lookup.setRequestEtag(etag: "xyz-789")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("xyz-789", sender.request.headers["Etag"])
    }

    func testBusinessDetailIncludeFieldsLandInUrl() {
        let (client, sender) = capturingClient()
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC123")
        lookup.addIncludeAttribute(attribute: "phone")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("phone", sender.request.parameters["include"])
    }

    func testBusinessDetailExcludeFieldsLandInUrl() {
        let (client, sender) = capturingClient()
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC123")
        lookup.addExcludeAttribute(attribute: "credit_score")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("credit_score", sender.request.parameters["exclude"])
    }

    func testBusinessDetailCustomParametersLandInUrl() {
        let (client, sender) = capturingClient()
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC123")
        lookup.addCustomParameter(parameter: "experimental", value: "1")
        lookup.addCustomParameter(parameter: "trace", value: "on")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("1", sender.request.parameters["experimental"])
        XCTAssertEqual("on", sender.request.parameters["trace"])
    }

    func testBusinessDetailIncludeExcludeAndCustomCombined() {
        let (client, sender) = capturingClient()
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC123")
        lookup.addIncludeAttribute(attribute: "phone")
        lookup.addExcludeAttribute(attribute: "credit_score")
        lookup.addCustomParameter(parameter: "trace", value: "on")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("phone", sender.request.parameters["include"])
        XCTAssertEqual("credit_score", sender.request.parameters["exclude"])
        XCTAssertEqual("on", sender.request.parameters["trace"])
    }

    // MARK: - Validation

    func testBusinessDetailRejectsEmptyBusinessId() {
        let (client, sender) = capturingClient()
        let result = client.sendBusinessDetailLookup(businessId: "", error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.FieldNotSetError.rawValue, self.error.code)
        XCTAssertNil(sender.request)
    }

    func testBusinessDetailRejectsWhitespaceBusinessId() {
        let (client, sender) = capturingClient()
        let result = client.sendBusinessDetailLookup(businessId: "   ", error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.FieldNotSetError.rawValue, self.error.code)
        XCTAssertNil(sender.request)
    }

    func testBusinessSummaryRejectsWhitespaceSmartyKey() {
        let (client, sender) = capturingClient()
        let result = client.sendBusinessLookup(smartyKey: "   ", error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.FieldNotSetError.rawValue, self.error.code)
        XCTAssertNil(sender.request)
    }

    func testBusinessSummaryRejectsAllWhitespaceFields() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()
        lookup.setSmartyKey(smarty_key: "   ")
        lookup.setStreet(street: "   ")
        lookup.setFreeform(freeform: "   ")

        let result = client.sendBusinessLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.FieldNotSetError.rawValue, self.error.code)
        XCTAssertNil(sender.request)
    }

    func testEnrichmentSummaryLookupSendsRequestEtagHeader() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()
        lookup.setSmartyKey(smarty_key: "1")
        lookup.setRequestEtag(etag: "abc-123")

        _ = client.sendPropertyPrincipalLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(self.error)
        XCTAssertEqual("abc-123", sender.request.headers["Etag"])
    }

    // MARK: - Detail array-shape handling

    func testBusinessDetailAcceptsSingleResult() {
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")
        let json = #"[{"smarty_key":"7","data_set_name":"business","business_id":"ABC","attributes":{"company_name":"Acme Corp"}}]"#
        let serializer = BusinessDetailSerializer()
        var err: NSError? = nil
        lookup.deserializeAndSetResults(serializer: serializer, payload: json.data(using: .utf8)!, error: &err)

        XCTAssertNil(err)
        let result = lookup.getResult()
        XCTAssertNotNil(result)
        XCTAssertEqual("ABC", result?.businessId)
        XCTAssertEqual("Acme Corp", result?.attributes?.companyName)
    }

    func testBusinessDetailAcceptsEmptyArray() {
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")
        let serializer = BusinessDetailSerializer()
        var err: NSError? = nil
        lookup.deserializeAndSetResults(serializer: serializer, payload: "[]".data(using: .utf8)!, error: &err)

        XCTAssertNil(err)
        XCTAssertNil(lookup.getResult())
    }

    func testBusinessDetailRejectsMultipleResults() {
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")
        let json = #"[{"smarty_key":"1"},{"smarty_key":"2"}]"#
        let serializer = BusinessDetailSerializer()
        var err: NSError? = nil
        lookup.deserializeAndSetResults(serializer: serializer, payload: json.data(using: .utf8)!, error: &err)

        XCTAssertNotNil(err)
        XCTAssertEqual(SmartyErrors.SSErrors.BusinessDetailMultipleResultsError.rawValue, err?.code)
        XCTAssertNil(lookup.getResult())
    }

    // MARK: - Response ETag capture (200 path)

    func testBusinessDetailCapturesResponseEtag() {
        let (client, _) = capturingClient(responseHeaders: ["Etag": "server-etag-1"])
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertEqual("server-etag-1", lookup.getResponseEtag())
    }

    func testBusinessSummaryCapturesResponseEtag() {
        let (client, _) = capturingClient(responseHeaders: ["Etag": "server-etag-summary"])
        let lookup = BusinessSummaryEnrichmentLookup(smartyKey: "1")

        _ = client.sendBusinessLookup(lookup: lookup, error: &self.error)

        XCTAssertEqual("server-etag-summary", lookup.getResponseEtag())
    }

    func testResponseEtagCaseInsensitiveHeader() {
        let (client, _) = capturingClient(responseHeaders: ["ETag": "standard-cased-etag"])
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertEqual("standard-cased-etag", lookup.getResponseEtag())
    }

    func testResponseEtagDoesNotClobberRequestEtag() {
        let (client, _) = capturingClient(responseHeaders: ["Etag": "server-etag-2"])
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")
        lookup.setRequestEtag(etag: "caller-etag")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertEqual("caller-etag", lookup.getRequestEtag())
        XCTAssertEqual("server-etag-2", lookup.getResponseEtag())
    }

    func testResponseEtagEmptyWhenHeaderAbsent() {
        let (client, _) = capturingClient(responseHeaders: [:])
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")
        lookup.setRequestEtag(etag: "caller-etag")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertEqual("caller-etag", lookup.getRequestEtag())
        XCTAssertEqual("", lookup.getResponseEtag())
    }

    // MARK: - 304 Not Modified via full StatusCodeSender

    func testBusinessDetailOn304SurfacesErrorAndCapturesResponseEtag() {
        // Wrap a raw 304 MockSender in StatusCodeSender so dispatch() sees both a populated
        // response and an NSError — the same shape that hits the client in production.
        let inner = MockSender(statusCode: 304, payload: "[]".data(using: .utf8)!, headers: ["Etag": "server-refreshed"])
        let client = USEnrichmentClient(sender: StatusCodeSender(inner: inner))
        let lookup = BusinessDetailEnrichmentLookup(businessId: "ABC")

        _ = client.sendBusinessDetailLookup(lookup: lookup, error: &self.error)

        XCTAssertEqual(SmartyErrors.SSErrors.NotModifiedInfo.rawValue, self.error.code)
        XCTAssertEqual("server-refreshed", self.error.userInfo[SmartyErrors.ResponseEtagKey] as? String)
        XCTAssertEqual("server-refreshed", lookup.getResponseEtag())
    }

    // MARK: - Shared validation applies to pre-existing endpoints

    func testPropertyPrincipalRejectsAllBlankInputs() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()

        let result = client.sendPropertyPrincipalLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.FieldNotSetError.rawValue, self.error.code)
        XCTAssertNil(sender.request)
    }

    func testGeoReferenceRejectsEmptySmartyKey() {
        let (client, sender) = capturingClient()

        let result = client.sendGeoReferenceLookup(smartyKey: "", error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.FieldNotSetError.rawValue, self.error.code)
        XCTAssertNil(sender.request)
    }

    func testSecondaryCountRejectsWhitespaceOnlyInputs() {
        let (client, sender) = capturingClient()
        let lookup = EnrichmentLookup()
        lookup.setSmartyKey(smarty_key: " ")
        lookup.setStreet(street: "\t")
        lookup.setFreeform(freeform: "\n")

        let result = client.sendSecondaryCountLookup(inputLookup: lookup, error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.FieldNotSetError.rawValue, self.error.code)
        XCTAssertNil(sender.request)
    }
}

// Capturing sender with configurable response headers. Returns an empty JSON array so that
// enrichment lookups deserialize cleanly (the default ResultTypes all accept `[]`).
fileprivate class CapturingSender: SmartySender {
    var request: SmartyRequest!
    let responseHeaders: [String: String]

    init(responseHeaders: [String: String]) {
        self.responseHeaders = responseHeaders
    }

    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.request = request
        let payload = "[]".data(using: .utf8)!
        return SmartyResponse(statusCode: 200, payload: payload, headers: responseHeaders)
    }
}
