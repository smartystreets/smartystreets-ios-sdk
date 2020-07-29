import XCTest
@testable import SmartyStreets

class USZipCodeResultTests: XCTestCase {
    
    var result:USZipCodeResult!
    var expectedJsonInput:NSArray!
    var obj:NSDictionary!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.result = USZipCodeResult(dictionary: NSDictionary())
        self.obj = ["status":"0","reason":"1","input_index":2,"city_states":[["city":"3","mailable_city":true,"state_abbreviation":"4","state":"5"]],"zipcodes":[["zipcode":"6","zipcode_type":"7","default_city":"8","county_fips":"9","county_name":"10","state_abbreviation":"11","state":"12","latitude":13.0,"longitude":14.0,"precision":"15","alternate_counties":[["county_fips":"16","county_name":"17","state_abbreviation":"18","state":"19"]]]]]
        self.expectedJsonInput = [["city":"Las Vegas","state":"NV","zipcode":"12345"],["city":"Provo","state":"Utah"],["zipcode":"54321"]]
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.expectedJsonInput = nil
        self.obj = nil
        self.error = nil
    }
    
    func testIsValidReturnsTrueWhenInputIsValid() {
        XCTAssertTrue(self.result!.isValid())
    }
    
    func testsIsValidReturnsTrueWhenInputIsNotValid() {
        self.result.status = "invalid_zipcode"
        self.result.reason = "invalid_reason"
        
        XCTAssertFalse(self.result!.isValid())
    }
    
    func testAllFieldsFilledCorrectly() {
        let result = USZipCodeResult(dictionary: self.obj)
        
        XCTAssertEqual(result.status, "0")
        XCTAssertEqual(result.reason, "1")
        XCTAssertEqual(result.inputIndex, 2)
        
        let city:USCity = result.cities![0]
        XCTAssertEqual(city.city, "3")
        XCTAssertTrue(city.mailablecity!)
        XCTAssertEqual(city.stateAbbreviation, "4")
        XCTAssertEqual(city.state, "5")
        
        let zip = result.zipCodes![0]
        XCTAssertEqual(zip.zipCode, "6")
        XCTAssertEqual(zip.zipCodeType, "7")
        XCTAssertEqual(zip.defaultCity, "8")
        XCTAssertEqual(zip.countyFips, "9")
        XCTAssertEqual(zip.countyName, "10")
        XCTAssertEqual(zip.stateAbbreviation, "11")
        XCTAssertEqual(zip.state, "12")
        XCTAssertEqual(zip.latitude, 13.0)
        XCTAssertEqual(zip.longitude, 14.0)
        XCTAssertEqual(zip.precision, "15")
        
        let altCounties = zip.alternateCounties![0]
        XCTAssertEqual(altCounties.countyFips, "16")
        XCTAssertEqual(altCounties.countyName, "17")
        XCTAssertEqual(altCounties.stateAbbreviation, "18")
        XCTAssertEqual(altCounties.state, "19")
    }
    
    func testWhenZipCodesAndCitiesAreNullCreatesNewNSMutableArray() {
        let result = USZipCodeResult(dictionary: NSDictionary())
        XCTAssertNotNil(result.zipCodes)
        XCTAssertNotNil(result.cities)
    }
    
    func testWhenAlternatecountiesIsNullCreatesNewNSMutableArray() {
        let result = USZipCodeResult(dictionary: ["zipcodes":[["":""]]])
        XCTAssertNotNil(result.zipCodes![0].alternateCounties)
    }
}
