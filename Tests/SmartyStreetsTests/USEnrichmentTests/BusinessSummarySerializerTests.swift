import XCTest
@testable import SmartyStreets

class BusinessSummarySerializerTests: XCTestCase {

    var serializer: BusinessSummarySerializer!
    var error: NSError!

    override func setUp() {
        super.setUp()
        serializer = BusinessSummarySerializer()
        error = nil
    }

    override func tearDown() {
        super.tearDown()
        serializer = nil
        error = nil
    }

    func testDeserializePopulatesResults() {
        let json = #"""
        [
            {
                "smarty_key": "325023201",
                "data_set_name": "business",
                "businesses": [
                    { "company_name": "Acme Corp", "business_id": "ABC123" },
                    { "company_name": "Beta LLC",  "business_id": "DEF456" }
                ]
            }
        ]
        """#

        let result = serializer.Deserialize(payload: json.data(using: .utf8), error: &self.error) as? [BusinessSummaryResult]

        XCTAssertNil(self.error)
        XCTAssertEqual(1, result?.count)
        XCTAssertEqual("325023201", result?[0].smartyKey)
        XCTAssertEqual("business", result?[0].dataSetName)
        XCTAssertEqual(2, result?[0].businesses?.count)
        XCTAssertEqual("Acme Corp", result?[0].businesses?[0].companyName)
        XCTAssertEqual("ABC123", result?[0].businesses?[0].businessId)
    }

    func testDeserializeEmptyArray() {
        let result = serializer.Deserialize(payload: "[]".data(using: .utf8), error: &self.error) as? [BusinessSummaryResult]

        XCTAssertNil(self.error)
        XCTAssertEqual(0, result?.count)
    }

    func testDeserializeNilPayloadRaisesObjectNilError() {
        let result = serializer.Deserialize(payload: nil, error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.ObjectNilError.rawValue, self.error.code)
    }

    func testDeserializeMalformedJSONRaisesInvalidTypeError() {
        let bad = "{not json".data(using: .utf8)
        let result = serializer.Deserialize(payload: bad, error: &self.error)

        XCTAssertNil(result)
        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.ObjectInvalidTypeError.rawValue, self.error.code)
    }

    func testSerializeNilRaisesObjectNilError() {
        _ = serializer.Serialize(obj: nil, error: &self.error)

        XCTAssertNotNil(self.error)
        XCTAssertEqual(SmartyErrors.SSErrors.ObjectNilError.rawValue, self.error.code)
    }

    func testSerializeEncodesLookupFields() {
        let lookup = BusinessSummaryEnrichmentLookup(smartyKey: "325023201")
        lookup.setStreet(street: "56 Union Ave")
        lookup.setCity(city: "Somerville")
        lookup.addIncludeAttribute(attribute: "phone")

        let data = serializer.Serialize(obj: lookup, error: &self.error)
        let json = String(data: data!, encoding: .utf8) ?? ""

        XCTAssertNil(self.error)
        XCTAssertTrue(json.contains("\"smarty_key\":\"325023201\""), "got: \(json)")
        XCTAssertTrue(json.contains("\"street\":\"56 Union Ave\""), "got: \(json)")
        XCTAssertTrue(json.contains("\"data_set_name\":\"business\""), "got: \(json)")
        XCTAssertTrue(json.contains("\"include_array\":[\"phone\"]"), "got: \(json)")
    }
}
