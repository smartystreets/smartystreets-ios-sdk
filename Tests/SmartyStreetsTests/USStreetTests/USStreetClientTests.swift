import XCTest
import SmartyStreets

class USStreetClientTests: XCTestCase {
    
    var serializer:USStreetSerializer!
    var client:USStreetClient!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.serializer = USStreetSerializer()
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.serializer = nil
        self.error = nil
    }
    
    func testSendingSingleFreeformLookup() {
        let expectedUrl = "http://localhost/?candidates=1"
        let sender = RequestCapturingSender()
        let client = USStreetClient(sender: sender, serializer: serializer)
        
        var lookup = USStreetLookup()
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        
        let actualUrl = sender.request.getUrl()
        
        XCTAssertEqual(actualUrl, expectedUrl)
    }
    
    func testSendingSingleFullyPopulatedLookup() {
        let capturingSender = RequestCapturingSender()
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: capturingSender)
        let client = USStreetClient(sender: sender, serializer: serializer)
        var lookup = USStreetLookup()
        
        lookup.addressee = "0"
        lookup.street = "1"
        lookup.secondary = "2"
        lookup.street2 = "3"
        lookup.urbanization = "4"
        lookup.city = "5"
        lookup.state = "6"
        lookup.zipCode = "7"
        lookup.lastline = "8"
        lookup.setMaxCandidates(max: 9, error: &self.error)
        XCTAssertNil(self.error)
        
        _ = client.sendLookup(lookup: &lookup, error: &self.error)
        XCTAssertNil(self.error)
        XCTAssertNotNil(capturingSender.request.getUrl())
    }

    func testFullBatch() {
        let responseDataTemplate = """
                                   {
                                       "input_index": %d,
                                       "candidate_index": %d,
                                       "delivery_line_1": "7270 Blackberry Trl",
                                       "last_line": "Trussville AL 35173-1292",
                                       "delivery_point_barcode": "351731292700",
                                       "components": {
                                         "primary_number": "7270",
                                         "street_name": "Blackberry",
                                         "street_suffix": "Trl",
                                         "city_name": "Trussville",
                                         "default_city_name": "Trussville",
                                         "state_abbreviation": "AL",
                                         "zipcode": "35173",
                                         "plus4_code": "1292",
                                         "delivery_point": "70",
                                         "delivery_point_check_digit": "0"
                                       },
                                       "metadata": {
                                         "record_type": "S",
                                         "zip_type": "Standard",
                                         "county_fips": "01073",
                                         "county_name": "Jefferson",
                                         "carrier_route": "R008",
                                         "congressional_district": "06",
                                         "rdi": "Residential",
                                         "elot_sequence": "0338",
                                         "elot_sort": "A",
                                         "latitude": 33.716353,
                                         "longitude": -86.533044,
                                         "precision": "Rooftop",
                                         "time_zone": "Central",
                                         "utc_offset": -6,
                                         "dst": true
                                       },
                                       "analysis": {
                                         "dpv_match_code": "Y",
                                         "dpv_footnotes": "AABB",
                                         "dpv_cmra": "N",
                                         "dpv_vacant": "N",
                                         "dpv_no_stat": "N",
                                         "active": "Y",
                                         "footnotes": "N#"
                                       }
                                     }
                                   """
        var data = " [" + String(format:responseDataTemplate, 0, 0)
        data = data + "," + String(format:responseDataTemplate, 1, 0)
        data = data + "," + String(format:responseDataTemplate, 2, 0)
        data = data + "," + String(format:responseDataTemplate, 3, 0)
        data = data + "," + String(format:responseDataTemplate, 4, 0)
        data = data + "," + String(format:responseDataTemplate, 4, 1)
        data = data + "," + String(format:responseDataTemplate, 4, 2)
        data = data + "," + String(format:responseDataTemplate, 4, 3)
        data = data + "," + String(format:responseDataTemplate, 4, 4)
        data = data + "]"

        let capturingSender = RequestCapturingDataSender(dataToReturn:data.data(using: .utf8)!)
        let sender = URLPrefixSender(urlPrefix: "http://localhost/", inner: capturingSender)
        let client = USStreetClient(sender: sender, serializer: serializer)
        let batch = USStreetBatch()

        for index in 1...5 {
            let lookup = USStreetLookup()
            lookup.addressee = "0" + String(index)
            lookup.street = "1" + String(index)
            lookup.secondary = "2" + String(index)
            lookup.street2 = "3" + String(index)
            lookup.urbanization = "4" + String(index)
            lookup.city = "5" + String(index)
            lookup.state = "6" + String(index)
            lookup.zipCode = "7" + String(index)
            lookup.lastline = "8" + String(index)
            lookup.setMaxCandidates(max: 9, error: &self.error)

            _ = batch.add(newAddress: lookup, error: &self.error)
            XCTAssertNil(self.error)
        }

        _ = client.sendBatch(batch: batch, error: &self.error)
        let item = batch.getLookupAtIndex(index: 4) as! USStreetLookup
        XCTAssertEqual(item.result.count, 5)
        XCTAssertNil(self.error)
        XCTAssertNotNil(capturingSender.request.getUrl())
    }
    
    func testEmptyBatchNotSent() {
        let sender = RequestCapturingSender()
        let client = USStreetClient(sender: sender, serializer: serializer)
        
        _ = client.sendBatch(batch: USStreetBatch(), error: &self.error)
        XCTAssertNil(sender.request)
    }
}
