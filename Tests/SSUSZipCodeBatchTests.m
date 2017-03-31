#import <XCTest/XCTest.h>
#import "SSUSZipCodeBatch.h"

@interface SSUSZipCodeBatchTests : XCTestCase

@end

@implementation SSUSZipCodeBatchTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetsLookupsByInputId {
    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    [lookup setInputId:@"hasInputId"];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertNotNil([batch getLookupById:@"hasInputId"]);
}

- (void)testGetsLookupsByIndex {
    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    [lookup setCity:@"Provo"];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    
    XCTAssertEqual(@"Provo", [[batch getLookupAtIndex:0] city]);
}

- (void)testReturnsCorrectSize {
    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    
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
    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    for (int i = 0; i < kSSUSZipCodeMaxBatchSize + 1; i++) {
        [batch add:lookup error:&error];
        
        if (error != nil)
            break;
    }
    
    XCTAssertEqual(kSSUSZipCodeMaxBatchSize, batch.count);
    NSString *details = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSUSZipCodeMaxBatchSize];
    XCTAssertEqualObjects(details, [error localizedDescription]);
}

- (void)testClearMethodClearsBothLookupCollections {
    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    NSError *error = nil;
    
    [batch add:lookup error:&error];
    [batch add:lookup error:&error];
    
    [batch removeAllObjects];
    
    XCTAssertEqual(0, [[batch allLookups] count]);
    XCTAssertEqual(0, [[batch namedLookups] count]);
}

@end
