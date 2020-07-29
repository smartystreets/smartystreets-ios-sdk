import XCTest
@testable import SmartyStreets

class USZipCodeBatchTests: XCTestCase {
    
    var batch:USZipCodeBatch!
    var lookup:USZipCodeLookup!
    var error:NSError!
    
    override func setUp() {
        super.setUp()
        self.batch = USZipCodeBatch()
        self.lookup = USZipCodeLookup(city: String(), state: String(), zipcode: String(), inputId: String())
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.batch = nil
        self.lookup = nil
        self.error = nil
    }
    
    func testGetsLookupsByInputId() {
        let key = "hasInputID"
        self.lookup.inputId = key
        let _ = self.batch.add(newAddress:self.lookup!, error: &self.error)
        XCTAssertNil(self.error)
        XCTAssertNotNil(self.batch.getLookupById(inputId: key))
    }
    
    func testGetLookupByIndex() {
        let city = "Provo"
        self.lookup.city = city
        let _ = self.batch.add(newAddress: self.lookup!, error: &self.error)
        print("The array looks like this... \(self.batch.allLookups)")
        let actualLookup:USZipCodeLookup = self.batch.getLookupAtIndex(index: 0) as! USZipCodeLookup
        XCTAssertEqual(actualLookup.city, city)
    }
    
    func testReturnsCorrectSize() {
        self.lookup.inputId = "inputId"
        let lookup2 = USZipCodeLookup(city: String(), state: String(), zipcode: String(), inputId: String())
        let lookup3 = USZipCodeLookup(city: String(), state: String(), zipcode: String(), inputId: String())
        
        let _ = batch.add(newAddress: self.lookup!, error: &self.error)
        let _ = batch.add(newAddress: lookup2, error: &self.error)
        let _ = batch.add(newAddress: lookup3, error: &self.error)
        
        XCTAssertEqual(batch.count(), 3)
    }
    
    func testAddingALookupWhenThereIsABatchIsFullError() {
        for _ in 0...batch.maxBatchSize {
            let _ = batch.add(newAddress: self.lookup!, error: &self.error)
            
            if self.error != nil {
                break
            }
        }
        
        XCTAssertEqual(batch.maxBatchSize, batch.count())
        let details = "Batch size cannot exceed \(batch.maxBatchSize)"
        XCTAssertEqual(self.error.localizedDescription, details)
    }
    
    func testClearMethodClearsBothLookupCollections() {
        let _ = batch.add(newAddress: self.lookup!, error: &self.error)
        let _ = batch.add(newAddress: self.lookup!, error: &self.error)
        
        batch.removeAllObjects()
        
        XCTAssertEqual(0, batch.allLookups.count)
        XCTAssertEqual(0, batch.namedLookups.count)
    }
}
