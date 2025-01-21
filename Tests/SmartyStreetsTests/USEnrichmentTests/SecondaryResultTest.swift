import XCTest
@testable import SmartyStreets

class USEnrichmentSecondaryResultTest: XCTestCase {
    
    var expectedJsonInput:String!
    var obj:NSDictionary!
    var sobj:String!
    var error:NSError!
    let serializer = SecondarySerializer()
    
    override func setUp() {
        super.setUp()
        expectedJsonInput = """
        {"city":"2","data_set_name":"secondary","data_subset_name":"","etag":"6","exclude_array":["9","10"],"freeform":"5","include_array":["7","8"],"smarty_key":"xxx","state":"3","street":"1","zipcode":"4"}
        """
        
        sobj = """
            [
                {
                    "smarty_key": "xxx",
                    "root_address": {
                        "secondary_count": 1,
                        "smarty_key": "xxx",
                        "primary_number": "primary_number",
                        "street_predirection": "street_predirection",
                        "street_name": "street_name",
                        "street_suffix": "street_suffix",
                        "street_postdirection": "street_postdirection",
                        "city_name": "city_name",
                        "state_abbreviation": "state_abbreviation",
                        "zipcode": "zipcode",
                        "plus4_code": "plus4_code"
                    },
                    "aliases": [
                        {
                            "smarty_key": "xxx",
                            "primary_number": "primary_number",
                            "street_predirection": "street_predirection",
                            "street_name": "street_name",
                            "street_suffix": "street_suffix",
                            "street_postdirection": "street_postdirection",
                            "city_name": "city_name",
                            "state_abbreviation": "state_abbreviation",
                            "zipcode": "zipcode",
                            "plus4_code": "plus4_code"
                        },
                        {
                            "smarty_key": "xxx",
                            "primary_number": "primary_number",
                            "street_predirection": "street_predirection",
                            "street_name": "street_name",
                            "street_suffix": "street_suffix",
                            "street_postdirection": "street_postdirection",
                            "city_name": "city_name",
                            "state_abbreviation": "state_abbreviation",
                            "zipcode": "zipcode",
                            "plus4_code": "plus4_code"
                        }
                    ],
                    "secondaries": [
                        {
                            "smarty_key": "smarty_key",
                            "secondary_designator": "secondary_designator",
                            "secondary_number": "secondary_number",
                            "plus4_code": "plus4_code"
                        },
                        {
                            "smarty_key": "smarty_key",
                            "secondary_designator": "secondary_designator",
                            "secondary_number": "secondary_number",
                            "plus4_code": "plus4_code"
                        }
                    ]
                }
            ]
        """
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.error = nil
    }
    
    func testSerialization() {
        let inputLookup = EnrichmentLookup()
        inputLookup.setSmartyKey(smarty_key: "xxx")
        inputLookup.setStreet(street: "1")
        inputLookup.setCity(city: "2")
        inputLookup.setState(state: "3")
        inputLookup.setZipcode(zipcode: "4")
        inputLookup.setFreeform(freeform: "5")
        inputLookup.setEtag(etag: "6")
        inputLookup.addIncludeAttribute(attribute: "7")
        inputLookup.addIncludeAttribute(attribute: "8")
        inputLookup.addExcludeAttribute(attribute: "9")
        inputLookup.addExcludeAttribute(attribute: "10")
        
        let lookup = SecondaryEnrichmentLookup(lookup: inputLookup)
        let actualBytes = serializer.Serialize(obj: lookup, error: &self.error)
        
        let data = Data(base64Encoded: (actualBytes?.base64EncodedString())!)
        let string = String(data: data!, encoding: .utf8)
        XCTAssertNil(self.error)
        XCTAssertEqual(string, expectedJsonInput)
    }
    
    func testAllFieldsFilledCorrectly() throws {
        let data = sobj.data(using: .utf8)
        // Convert the JSON string to a JSON object
        let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]]
        // Convert the JSON object to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject!, options: .prettyPrinted)
        
        // Deserialize the JSON data
        let results = serializer.Deserialize(payload: jsonData, error: &self.error) as? [SecondaryResult]
        print(results!)
        let result = results![0]
        
        XCTAssertEqual("xxx", result.smartyKey)
        
        let rootAddress = result.rootAddress
        
        XCTAssertEqual(1, rootAddress?.secondaryCount!)
        XCTAssertEqual("xxx", rootAddress?.smartyKey!.lowercased())
        XCTAssertEqual("primary_number", rootAddress?.primaryNumber!.lowercased())
        XCTAssertEqual("street_predirection", rootAddress?.streetPredirection!.lowercased())
        XCTAssertEqual("street_name", rootAddress?.streetName!.lowercased())
        XCTAssertEqual("street_suffix", rootAddress?.streetSuffix!.lowercased())
        XCTAssertEqual("street_postdirection", rootAddress?.streetPostdirection!.lowercased())
        XCTAssertEqual("city_name", rootAddress?.cityName!.lowercased())
        XCTAssertEqual("state_abbreviation", rootAddress?.stateAbbreviation!.lowercased())
        XCTAssertEqual("zipcode", rootAddress?.zipcode!.lowercased())
        XCTAssertEqual("plus4_code", rootAddress?.plus4Code!.lowercased())
        
        let aliases1 = result.aliases?[0]
        
        XCTAssertEqual("xxx", aliases1?.smartyKey!.lowercased())
        XCTAssertEqual("primary_number", aliases1?.primaryNumber!.lowercased())
        XCTAssertEqual("street_predirection", aliases1?.streetPredirection!.lowercased())
        XCTAssertEqual("street_name", aliases1?.streetName!.lowercased())
        XCTAssertEqual("street_suffix", aliases1?.streetSuffix!.lowercased())
        XCTAssertEqual("street_postdirection", aliases1?.streetPostdirection!.lowercased())
        XCTAssertEqual("city_name", aliases1?.cityName!.lowercased())
        XCTAssertEqual("state_abbreviation", aliases1?.stateAbbreviation!.lowercased())
        XCTAssertEqual("zipcode", aliases1?.zipcode!.lowercased())
        XCTAssertEqual("plus4_code", aliases1?.plus4Code!.lowercased())
        
        let aliases2 = result.aliases?[1]
        
        XCTAssertEqual("xxx", aliases2?.smartyKey!.lowercased())
        XCTAssertEqual("primary_number", aliases2?.primaryNumber!.lowercased())
        XCTAssertEqual("street_predirection", aliases2?.streetPredirection!.lowercased())
        XCTAssertEqual("street_name", aliases2?.streetName!.lowercased())
        XCTAssertEqual("street_suffix", aliases2?.streetSuffix!.lowercased())
        XCTAssertEqual("street_postdirection", aliases2?.streetPostdirection!.lowercased())
        XCTAssertEqual("city_name", aliases2?.cityName!.lowercased())
        XCTAssertEqual("state_abbreviation", aliases2?.stateAbbreviation!.lowercased())
        XCTAssertEqual("zipcode", aliases2?.zipcode!.lowercased())
        XCTAssertEqual("plus4_code", aliases2?.plus4Code!.lowercased())
        
        let secondaries1 = result.secondaries?[0]
        
        XCTAssertEqual("smarty_key", secondaries1?.smartyKey!.lowercased())
        XCTAssertEqual("secondary_designator", secondaries1?.secondaryDesignator!.lowercased())
        XCTAssertEqual("secondary_number", secondaries1?.secondaryNumber!.lowercased())
        XCTAssertEqual("plus4_code", secondaries1?.plus4Code!.lowercased())
        
        let secondaries2 = result.secondaries?[1]
        
        XCTAssertEqual("smarty_key", secondaries2?.smartyKey!.lowercased())
        XCTAssertEqual("secondary_designator", secondaries2?.secondaryDesignator!.lowercased())
        XCTAssertEqual("secondary_number", secondaries2?.secondaryNumber!.lowercased())
        XCTAssertEqual("plus4_code", secondaries2?.plus4Code!.lowercased())
    }
}
