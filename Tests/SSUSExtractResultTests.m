#import <XCTest/XCTest.h>
#import "SSUSExtractResult.h"

@interface SSUSExtractResultTests : XCTestCase {
    NSDictionary *obj;
}

@end

@implementation SSUSExtractResultTests

- (void)setUp {
    [super setUp];
    
    obj = @{
            @"meta": @{
                        @"lines": [NSNumber numberWithInteger:1],
                        @"unicode": @YES,
                        @"address_count": [NSNumber numberWithInteger:2],
                        @"verified_count": [NSNumber numberWithInteger:3],
                        @"bytes": [NSNumber numberWithInteger:4],
                        @"character_count": [NSNumber numberWithInteger:5]
            },
            @"addresses": [NSArray arrayWithObjects:
                    @{
                        @"text": @"6",
                        @"verified": @YES,
                        @"line": [NSNumber numberWithInteger:7],
                        @"start": [NSNumber numberWithInteger:8],
                        @"end": [NSNumber numberWithInteger:9],
                        @"api_output": [NSArray<SSUSStreetCandidate*> new]
                    },
                    @{
                        @"text":@"10"
                    }, nil]
            };
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAllFieldsFilledCorrectly {
    SSUSExtractResult *result = [[SSUSExtractResult alloc] initWithDictionary:obj];
    
    SSUSExtractMetadata *metadata = result.metadata;
    XCTAssertNotNil(metadata);
    XCTAssertEqual(1, metadata.lines);
    XCTAssertTrue(metadata.isUnicode);
    XCTAssertEqual(2, metadata.addressCount);
    XCTAssertEqual(3, metadata.verifiedCount);
    XCTAssertEqual(4, metadata.bytes);
    XCTAssertEqual(5, metadata.characterCount);
    
    SSUSExtractAddress *address = [result getAddressAtIndex:0];
    XCTAssertNotNil(address);
    XCTAssertEqual(@"6", address.text);
    XCTAssertTrue(address.isVerified);
    XCTAssertEqual(7, address.line);
    XCTAssertEqual(8, address.start);
    XCTAssertEqual(9, address.end);
    XCTAssertEqual(@"10", [[result.addresses objectAtIndex:1] text]);
    XCTAssertNotNil(address.candidates);
}

- (void)testWhenCandidatesIsNullCreatesNewNSMutableArray {
    NSNull *nullObj = [NSNull null];
    obj = @{
            @"api_output": nullObj
            };
    SSUSExtractAddress *address = [[SSUSExtractAddress alloc] initWithDictionary:obj];
    XCTAssertNotNil(address.candidates);
}

- (void)testWhenAddressIsNullCreatesNewNSMutableArray {
    NSNull *nullObj = [NSNull null];
    obj = @{
            @"addresses": nullObj
            };
    SSUSExtractResult *result = [[SSUSExtractResult alloc] initWithDictionary:obj];
    XCTAssertNotNil(result.addresses);
}

@end
