import XCTest
@testable import SmartyStreets

class USStreetCandidateTests: XCTestCase {
    
    var expectedJsonInput:String!
    var obj:NSDictionary!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        expectedJsonInput = """
        [{\"state\":\"state_value\",\"secondary\":\"secondary\",\"street2\":\"street2_value\",\"street\":\"street_value\",\"maxCandidates\":5,\"urbanization\":\"urbanization_value\",\"matchStrategy\":\"match_value\",\"city\":\"city_value\",\"result\":[],\"zipCode\":\"zipCode_value\",\"addressee\":\"addressee_value\",\"lastline\":\"lastline_value\"},{\"result\":[],\"maxCandidates\":1,\"state\":\"California\",\"street\":\"1600 amphitheatre parkway\",\"city\":\"Mountain view\"},{\"street\":\"1 Rosedale, Baltimore, Maryland\"}]
        """
        
        obj = [
            "input_index": 0,
            "candidate_index": 1,
            "addressee": "2",
            "delivery_line_1": "3",
            "delivery_line_2": "4",
            "last_line": "5",
            "delivery_point_barcode": "6",
            "components": [
                "urbanization": "7",
                "primary_number": "8",
                "street_name": "9",
                "street_predirection": "10",
                "street_postdirection": "11",
                "street_suffix": "12",
                "secondary_number": "13",
                "secondary_designator": "14",
                "extra_secondary_number": "15",
                "extra_secondary_designator": "16",
                "pmb_designator": "17",
                "pmb_number": "18",
                "city_name": "19",
                "default_city_name": "20",
                "state_abbreviation": "21",
                "zipcode": "22",
                "plus4_code": "23",
                "delivery_point": "24",
                "delivery_point_check_digit": "25"
            ],
            "metadata": [
                "record_type": "26",
                "zip_type": "27",
                "county_fips": "28",
                "county_name": "29",
                "carrier_route": "30",
                "congressional_district": "31",
                "building_default_indicator": "32",
                "rdi": "33",
                "elot_sequence": "34",
                "elot_sort": "35",
                "latitude": 36.0,
                "longitude": 37.0,
                "precision": "38",
                "time_zone": "39",
                "utc_offset": 40.0,
                "dst": true,
                "ews_match": true
            ],
            "analysis": [
                "dpv_match_code": "42",
                "dpv_footnotes": "43",
                "dpv_cmra": "44",
                "dpv_vacant": "45",
                "active": "46",
                "ews_match": true,
                "footnotes": "48",
                "lacslink_code": "49",
                "lacslink_indicator": "50",
                "suitelink_match": true,
                "dpv_no_stat": "51"
            ]
        ]
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.error = nil
    }
    
    func testSerialization() {
        let serializer = USStreetSerializer()
        let lookups = NSMutableArray()
        
        let lookup1 = USStreetLookup()
        lookup1.street = "street_value"
        lookup1.street2 = "street2_value"
        lookup1.secondary = "secondary"
        lookup1.city = "city_value"
        lookup1.state = "state_value"
        lookup1.zipCode = "zipCode_value"
        lookup1.lastline = "lastline_value"
        lookup1.addressee = "addressee_value"
        lookup1.urbanization = "urbanization_value"
        lookup1.setMaxCandidates(max:5, error:&self.error)
        lookup1.matchStrategy = "match_value"
        
        let lookup2 = USStreetLookup()
        lookup2.street = "1600 amphitheatre parkway"
        lookup2.city = "Mountain view"
        lookup2.state = "California"
        
        lookups.add(lookup1)
        lookups.add(lookup2)
        lookups.add(USStreetLookup(freeformAddress: "1 Rosedale, Baltimore, Maryland"))
        
        let actualBytes = serializer.Serialize(obj: lookups, error: &self.error)
        
        let data = Data(base64Encoded: (actualBytes?.base64EncodedString())!)
        let string = String(data: data!, encoding: .utf8)
        XCTAssertNil(self.error)
        XCTAssertEqual(string, expectedJsonInput)
    }
    
    func testAllFieldsFilledCorrectly() {
        let candidate = USStreetCandidate(dictionary: obj)
        
        XCTAssertEqual(0, candidate.inputIndex)
        XCTAssertEqual(1, candidate.candidateIndex)
        XCTAssertEqual("2", candidate.addressee)
        XCTAssertEqual("3", candidate.deliveryLine1)
        XCTAssertEqual("4", candidate.deliveryLine2)
        XCTAssertEqual("5", candidate.lastline)
        XCTAssertEqual("6", candidate.deliveryPointBarcode)
        
        let components = candidate.components!
        XCTAssertEqual("7", components.urbanization)
        XCTAssertEqual("8", components.primaryNumber)
        XCTAssertEqual("9", components.streetName)
        XCTAssertEqual("10", components.streetPredirection)
        XCTAssertEqual("11", components.streetPostdirection)
        XCTAssertEqual("12", components.streetSuffix)
        XCTAssertEqual("13", components.secondaryNumber)
        XCTAssertEqual("14", components.secondaryDesignator)
        XCTAssertEqual("15", components.extraSecondaryNumber)
        XCTAssertEqual("16", components.extraSecondaryDesignator)
        XCTAssertEqual("17", components.pmbDesignator)
        XCTAssertEqual("18", components.pmbNumber)
        XCTAssertEqual("19", components.cityName)
        XCTAssertEqual("20", components.defaultCityName)
        XCTAssertEqual("21", components.state)
        XCTAssertEqual("22", components.zipCode)
        XCTAssertEqual("23", components.plus4Code)
        XCTAssertEqual("24", components.deliveryPoint)
        XCTAssertEqual("25", components.deliveryPointCheckDigit)
        
        let metadata = candidate.metadata!
        XCTAssertEqual("26", metadata.recordType)
        XCTAssertEqual("27", metadata.zipType)
        XCTAssertEqual("28", metadata.countyFips)
        XCTAssertEqual("29", metadata.countyName)
        XCTAssertEqual("30", metadata.carrierRoute)
        XCTAssertEqual("31", metadata.congressionalDistrict)
        XCTAssertEqual("32", metadata.buildingDefaultIndicator)
        XCTAssertEqual("33", metadata.rdi)
        XCTAssertEqual("34", metadata.elotSequence)
        XCTAssertEqual("35", metadata.elotSort)
        XCTAssertEqual(36, metadata.latitude)
        XCTAssertEqual(37, metadata.longitude)
        XCTAssertEqual("38", metadata.precision)
        XCTAssertEqual("39", metadata.timeZone)
        XCTAssertEqual(40, metadata.utcOffset)
        XCTAssertEqual(true, metadata.obeysDst)
        XCTAssertEqual(true, metadata.isEwsMatch)
        
        let analysis = candidate.analysis!
        XCTAssertEqual("42", analysis.dpvMatchCode)
        XCTAssertEqual("43", analysis.dpvFootnotes)
        XCTAssertEqual("44", analysis.cmra)
        XCTAssertEqual("45", analysis.vacant)
        XCTAssertEqual("46", analysis.active)
        XCTAssertEqual("48", analysis.footnotes)
        XCTAssertEqual("49", analysis.lacsLinkCode)
        XCTAssertEqual("50", analysis.lacsLinkIndicator)
        XCTAssertEqual(true, analysis.isSuiteLinkMatch)
        XCTAssertEqual("51", analysis.noStat)
    }
}
