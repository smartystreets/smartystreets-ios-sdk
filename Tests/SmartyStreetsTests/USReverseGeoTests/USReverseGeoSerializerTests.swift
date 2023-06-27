import XCTest
@testable import SmartyStreets

class USReverseGeoSerializerTests: XCTestCase {
    
    let jsonData = """
        {
            "results": [
                {
                    "coordinate": {
                        "latitude": 40.111111,
                        "longitude": -111.111111,
                        "accuracy": "Rooftop",
                        "license": 0
                    },
                    "distance": 2.7207432,
                    "address": {
                        "street": "2335 S State St",
                        "city": "Provo",
                        "state_abbreviation": "UT",
                        "zipcode": "84606"
                    }
                },
            ]
        }
    """
    
    var serializer:USReverseGeoSerializer!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        serializer = USReverseGeoSerializer()
        error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        serializer = nil
        error = nil
    }
    
    func testSerialize() {
        let expectedOutput = """
        {"source":"","longitude":"-111.11111111","latitude":"44.88888889"}
        """
        
        let lookup = USReverseGeoLookup(latitude: 44.888888888, longitude: -111.111111111, source: "")
        let data:Data = serializer.Serialize(obj: lookup, error: &self.error)
        let decodedData = Data(base64Encoded: data.base64EncodedString())
        let decodedString = String(data: decodedData!, encoding: .utf8)
        
        XCTAssertNil(self.error)
        XCTAssertEqual(decodedString, expectedOutput)
    }
    
    func testDeserializeResult() {
        let result:USReverseGeoResponse? = serializer.Deserialize(payload: jsonData.data(using: .utf8), error: &self.error) as? USReverseGeoResponse
        
        XCTAssertNotNil(result)
    }
    
}
