#import <XCTest/XCTest.h>
#import "SSZipCodeBatch.h"

@interface SSBatchTests : XCTestCase

@end

@implementation SSBatchTests

- (void)setUp {
    [super setUp];

}

- (void)tearDown {

    [super tearDown];
}

- (void)testGetsLookupsByInputId {
    SSZipCodeBatch *batch = [[SSZipCodeBatch alloc] init];
    SSZipCodeLookup *lookup = [[SSZipCodeLookup alloc] init];
    [lookup setInputId:@"hasInputId"];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertNotNil([batch getLookupById:@"hasInputId"]);
}

- (void)testGetsLookupsByIndex {
    SSZipCodeBatch *batch = [[SSZipCodeBatch alloc] init];
    SSZipCodeLookup *lookup = [[SSZipCodeLookup alloc] init];
    [lookup setCity:@"Provo"];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertEqual(@"Provo", [[batch getLookupByIndex:0] city]);
}

- (void)testReturnsCorrectSize {
    SSZipCodeBatch *batch = [[SSZipCodeBatch alloc] init];
    
    SSZipCodeLookup *lookup1 = [[SSZipCodeLookup alloc] init];
    [lookup1 setInputId:@"inputId"];
    SSZipCodeLookup *lookup2 = [[SSZipCodeLookup alloc] init];
    SSZipCodeLookup *lookup3 = [[SSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup1 error:&error];
    [batch add:lookup2 error:&error];
    [batch add:lookup3 error:&error];
    
    XCTAssertEqual(3, [batch count]);
}

- (void)testAddingALookupWhenThereIsABatchIsFullError {
    SSZipCodeBatch *batch = [[SSZipCodeBatch alloc] init];
    SSZipCodeLookup *lookup = [[SSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    for (int i = 0; i < kSSZipCodeMaxBatchSize + 1; i++) {
        [batch add:lookup error:&error];
        
        if (error != nil)
            break;
    }
    
    XCTAssertEqual(kSSZipCodeMaxBatchSize, batch.count);
    NSString *details = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSZipCodeMaxBatchSize];
    XCTAssertEqualObjects(details, [error localizedDescription]);
}

- (void)testClearMethodClearsBothLookupCollections {
    SSZipCodeBatch *batch = [[SSZipCodeBatch alloc] init];
    SSZipCodeLookup *lookup = [[SSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    [batch add:lookup error:&error];
    
    [batch removeAllObjects];
    
    XCTAssertEqual(0, [[batch allLookups] count]);
    XCTAssertEqual(0, [[batch namedLookups] count]);
}

@end
