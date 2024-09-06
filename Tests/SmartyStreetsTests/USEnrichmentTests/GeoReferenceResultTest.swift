import XCTest
@testable import SmartyStreets

class USEnrichmentGeoReferenceResultTest: XCTestCase {
    
    var expectedJsonInput:String!
    var obj:NSDictionary!
    var sobj:String!
    var error:NSError!
    let serializer = GeoReferenceSerializer()
    
    override func setUp() {
        super.setUp()
        expectedJsonInput = """
        {"data_set_name":"geo-reference","data_subset_name":"","smarty_key":"xxx"}
        """
        
        sobj = """
            [
                {
                    "smarty_key": "xxx",
                    "data_set_name": "geo-reference",
                    "attributes": {
                        "census_block": {
                            "accuracy": "accuracy",
                            "geoid": "geoid"
                        },
                        "census_county_division": {
                            "accuracy": "accuracy",
                            "code": "code",
                            "name": "name"
                        },
                        "census_tract": {
                            "code": "code"
                        },
                        "core_based_stat_area": {
                            "code": "code",
                            "name": "name"
                        },
                        "place": {
                            "accuracy": "accuracy",
                            "code": "code",
                            "name": "name",
                            "type": "type"
                        }
                    }
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
        let lookup = GeoReferenceEnrichmentLookup(smartyKey: "xxx")
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
        let results = serializer.Deserialize(payload: jsonData, error: &self.error) as? [GeoReferenceResult]
        print(results!)
        let result = results![0]

        guard let attributes = result.attributes else {
            print("Attributes was null")
            return
        }
        
        XCTAssertEqual("xxx", result.smartyKey)
        XCTAssertEqual("geo-reference", result.dataSetName)
        XCTAssertEqual(nil, result.dataSubsetName)
        
        let census_block = attributes.censusBlock
        
        XCTAssertEqual("accuracy", census_block?.accuracy!.lowercased())
        XCTAssertEqual("geoid", census_block?.geoid!.lowercased())
        
        let census_county_division = attributes.censusCountyDivision
        
        XCTAssertEqual("accuracy", census_county_division?.accuracy!.lowercased())
        XCTAssertEqual("code", census_county_division?.code!.lowercased())
        XCTAssertEqual("name", census_county_division?.name!.lowercased())
        
        let census_tract = attributes.censusTract
        
        XCTAssertEqual("code", census_tract?.code!.lowercased())
        
        let core_based_stat_area = attributes.coreBasedStatArea
        
        XCTAssertEqual("code", core_based_stat_area?.code!.lowercased())
        XCTAssertEqual("name", core_based_stat_area?.name!.lowercased())
        
        let place = attributes.place
        
        XCTAssertEqual("accuracy", place?.accuracy!.lowercased())
        XCTAssertEqual("code", place?.code!.lowercased())
        XCTAssertEqual("name", place?.name!.lowercased())
        XCTAssertEqual("type", place?.type!.lowercased())
    }
}
