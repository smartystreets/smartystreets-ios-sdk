#import <XCTest/XCTest.h>
#import "SSStreetBatch.h"

@interface SSStreetBatchTests : XCTestCase

@end

@implementation SSStreetBatchTests

- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetsLookupByInputId {
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    SSStreetLookup *lookup = [[SSStreetLookup alloc] init];
    lookup.inputId = @"hasInputId";
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertEqualObjects(lookup, [batch getLookupById:@"hasInputId"]);
}

- (void)testGetsLookupByIndex {
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    SSStreetLookup *lookup = [[SSStreetLookup alloc] init];
    lookup.city = @"Provo";
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertEqualObjects(@"Provo", [[batch getLookupAtIndex:0] city]);
}

- (void)testReturnsCorrectSize {
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    SSStreetLookup *lookup1 = [[SSStreetLookup alloc] init];
    lookup1.inputId = @"inputId";
    SSStreetLookup *lookup2 = [[SSStreetLookup alloc] init];
    SSStreetLookup *lookup3 = [[SSStreetLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup1 error:&error];
    [batch add:lookup2 error:&error];
    [batch add:lookup3 error:&error];
    
    XCTAssertEqual(3, [batch count]);
}

- (void)testAddingALookupWhenThereIsABatchIsFullError {
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    SSStreetLookup *lookup = [[SSStreetLookup alloc] init];
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

- (void)testResetMethodResetsHeadersAndLookups {
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    SSStreetLookup *lookup = [[SSStreetLookup alloc] init];
    NSError *error = nil;
    batch.standardizeOnly = YES;
    batch.includeInvalid = YES;
    
    [batch add:lookup error:&error];
    
    [batch reset];
    
    XCTAssertEqual(0, batch.allLookups.count);
    XCTAssertEqual(0, batch.namedLookups.count);
    XCTAssertFalse(batch.includeInvalid);
    XCTAssertFalse(batch.standardizeOnly);
}

- (void)testClearMethodClearsBothLookupCollectionsButNotHeaders {
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    SSStreetLookup *lookup = [[SSStreetLookup alloc] init];
    NSError *error = nil;
    batch.standardizeOnly = YES;
    batch.includeInvalid = YES;
    
    [batch add:lookup error:&error];
    
    [batch removeAllObjects];
    
    XCTAssertEqual(0, batch.allLookups.count);
    XCTAssertEqual(0, batch.namedLookups.count);
    XCTAssertTrue(batch.includeInvalid);
    XCTAssertTrue(batch.standardizeOnly);
}

@end
