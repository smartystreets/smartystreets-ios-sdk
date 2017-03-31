#import <XCTest/XCTest.h>
#import "SSUSStreetBatch.h"

@interface SSUSStreetBatchTests : XCTestCase

@end

@implementation SSUSStreetBatchTests

- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetsLookupByInputId {
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    SSUSStreetLookup *lookup = [[SSUSStreetLookup alloc] init];
    lookup.inputId = @"hasInputId";
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertEqualObjects(lookup, [batch getLookupById:@"hasInputId"]);
}

- (void)testGetsLookupByIndex {
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    SSUSStreetLookup *lookup = [[SSUSStreetLookup alloc] init];
    lookup.city = @"Provo";
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertEqualObjects(@"Provo", [[batch getLookupAtIndex:0] city]);
}

- (void)testReturnsCorrectSize {
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    SSUSStreetLookup *lookup1 = [[SSUSStreetLookup alloc] init];
    lookup1.inputId = @"inputId";
    SSUSStreetLookup *lookup2 = [[SSUSStreetLookup alloc] init];
    SSUSStreetLookup *lookup3 = [[SSUSStreetLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup1 error:&error];
    [batch add:lookup2 error:&error];
    [batch add:lookup3 error:&error];
    
    XCTAssertEqual(3, [batch count]);
}

- (void)testAddingALookupWhenThereIsABatchIsFullError {
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    SSUSStreetLookup *lookup = [[SSUSStreetLookup alloc] init];
    NSError *error = nil;
    
    for (int i = 0; i < kSSStreetMaxBatchSize + 1; i++) {
        [batch add:lookup error:&error];
        
        if (error != nil)
            break;
    }
    
    XCTAssertEqual(kSSStreetMaxBatchSize, batch.count);
    NSString *details = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSStreetMaxBatchSize];
    XCTAssertEqualObjects(details, [error localizedDescription]);
}

- (void)testClearMethodClearsBothLookupCollections {
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    SSUSStreetLookup *lookup = [[SSUSStreetLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    [batch add:lookup error:&error];
    
    [batch removeAllObjects];
    
    XCTAssertEqual(0, batch.allLookups.count);
    XCTAssertEqual(0, batch.namedLookups.count);
}

@end
