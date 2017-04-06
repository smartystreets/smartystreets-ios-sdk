#import <XCTest/XCTest.h>
#import "SSBatch.h"
#import "SSUSZipCodeLookup.h"

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
    SSBatch *batch = [[SSBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    [lookup setInputId:@"hasInputId"];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertNotNil([batch getLookupById:@"hasInputId"]);
}

- (void)testGetsLookupsByIndex {
    SSBatch *batch = [[SSBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    [lookup setCity:@"Provo"];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    SSUSZipCodeLookup *actualLookup = [batch getLookupAtIndex:0];
    NSString *city = actualLookup.city;
    
    XCTAssertEqual(@"Provo", city);
}

- (void)testReturnsCorrectSize {
    SSBatch *batch = [[SSBatch alloc] init];
    SSUSZipCodeLookup *lookup1 = [[SSUSZipCodeLookup alloc] init];
    [lookup1 setInputId:@"inputId"];
    SSUSZipCodeLookup *lookup2 = [[SSUSZipCodeLookup alloc] init];
    SSUSZipCodeLookup *lookup3 = [[SSUSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup1 error:&error];
    [batch add:lookup2 error:&error];
    [batch add:lookup3 error:&error];
    
    XCTAssertEqual(3, [batch count]);
}

- (void)testAddingALookupWhenThereIsABatchIsFullError {
    SSBatch *batch = [[SSBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    for (int i = 0; i < kSSMaxBatchSize + 1; i++) {
        [batch add:lookup error:&error];
        
        if (error != nil)
            break;
    }
    
    XCTAssertEqual(kSSMaxBatchSize, batch.count);
    NSString *details = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSMaxBatchSize];
    XCTAssertEqualObjects(details, [error localizedDescription]);
}

- (void)testClearMethodClearsBothLookupCollections {
    SSBatch *batch = [[SSBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    [batch add:lookup error:&error];
    
    [batch removeAllObjects];
    
    XCTAssertEqual(0, [[batch allLookups] count]);
    XCTAssertEqual(0, [[batch namedLookups] count]);
}

@end
