#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"

@interface SSJsonSerializerTests : XCTestCase

@end

@implementation SSJsonSerializerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSerializationOfNullValues {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    NSData *results = [serializer serialize:nil withClassType:nil error:&error];
    
    XCTAssertNil(results);
}

- (void)testDeserializationOfNullStream {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    NSArray *result = [serializer deserialize:nil error:&error];
    
    XCTAssertNil(result);
}

@end
