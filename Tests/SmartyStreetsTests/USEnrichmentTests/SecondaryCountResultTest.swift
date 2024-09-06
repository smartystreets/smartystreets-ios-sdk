import XCTest
@testable import SmartyStreets

class USEnrichmentSecondaryCountResultTest: XCTestCase {
    
    var expectedJsonInput:String!
    var obj:NSDictionary!
    var sobj:String!
    var error:NSError!
    let serializer = SecondaryCountSerializer()
    
    override func setUp() {
        super.setUp()
        expectedJsonInput = """
        {"data_set_name":"secondary","data_subset_name":"count","smarty_key":"xxx"}
        """
        
        sobj = """
            [
                {
                    "smarty_key": "xxx",
                    "count": 1
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
        let lookup = SecondaryCountEnrichmentLookup(smartyKey: "xxx")
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
        let results = serializer.Deserialize(payload: jsonData, error: &self.error) as? [SecondaryCountResult]
        print(results!)
        let result = results![0]
        
        XCTAssertEqual("xxx", result.smartyKey)
        XCTAssertEqual(1, result.count)
    }
}
