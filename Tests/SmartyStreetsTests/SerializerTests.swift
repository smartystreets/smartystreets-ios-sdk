import XCTest
@testable import SmartyStreets

class SerializerTests: XCTestCase {
    
    let jsonData = """
[
    {
    "city":"Provo",
    "state":"UT",
    "zipcode":"84604",
    "input_id":"867-5309",
    "results":{
        "input_index":0,
        "city_states":[{"city":"Provo",
                        "state_abbreviation":"UT",
                        "state":"Utah",
                        "mailable_city":true}],
        "zipcodes":[{"zipcode":"84604",
                     "zipcode_type":"S",
                     "default_city":"Provo",
                     "county_fips":"49049",
                     "county_name":"Utah",
                     "state_abbreviation":"UT",
                     "state":"Utah",
                     "latitude":40.26763,
                     "longitude":-111.65763,
                     "precision":"Zip5",
                     "alternate_counties":[{"county_fips":"49051",
                                            "county_name":"Wasatch",
                                            "state_abbreviation":"UT",
                                            "state":"Utah"}]}]
    }},
    {
    "city":"Provo",
    "state":"UT",
    "zipcode":"84604",
    "input_id":"867-5309",
    "results":{
        "input_index":0,
        "city_states":[{"city":"Provo",
                        "state_abbreviation":"UT",
                        "state":"Utah",
                        "mailable_city":true}],
        "zipcodes":[{"zipcode":"84604",
                     "zipcode_type":"S",
                     "default_city":"Provo",
                     "county_fips":"49049",
                     "county_name":"Utah",
                     "state_abbreviation":"UT",
                     "state":"Utah",
                     "latitude":40.26763,
                     "longitude":-111.65763,
                     "precision":"Zip5",
                     "alternate_counties":[{"county_fips":"49051",
                                            "county_name":"Wasatch",
                                            "state_abbreviation":"UT",
                                            "state":"Utah"}]}]
    }}]
"""
    
    var serializer:USZipCodeSerializer!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        serializer = USZipCodeSerializer()
        error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        serializer = nil
        error = nil
    }
    
    func testSerialize() {
        let expectedOutput = """
        [{"state":"02","inputId":"04","city":"01","zipcode":"03"},{"state":"06","inputId":"08","city":"05","zipcode":"07"}]
        """
        let lookup1 = USZipCodeLookup(city: "01", state: "02", zipcode: "03", inputId: "04")
        let lookup2 = USZipCodeLookup(city: "05", state: "06", zipcode: "07", inputId: "08")
        let batch = USZipCodeBatch()
        _ = batch.add(newAddress: lookup1, error: &self.error)
        _ = batch.add(newAddress: lookup2, error: &self.error)
        let data:Data = serializer.Serialize(obj: batch.allLookups, error: &self.error)
        let decodedData = Data(base64Encoded: data.base64EncodedString())
        let decodedString = String(data: decodedData!, encoding: .utf8)
        
        XCTAssertNil(self.error)
        XCTAssertEqual(decodedString, expectedOutput)
    }
    
    func testDeserializeResult() {
        let result:[USZipCodeResult] = (serializer.Deserialize(payload: jsonData.data(using: .utf8), error: &self.error) as? [USZipCodeResult])!
        
        XCTAssertNotNil(result[0])
        XCTAssertNotNil(result[1])
    }
    
}
