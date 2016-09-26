#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"
#import "SSZipCodeLookup.h"
#import "SSResult.h"

@interface SSJsonSerializerTests : XCTestCase {
    NSString *expectedJsonInput;
}

@property (readonly, nonatomic) SSJsonSerializer *serializer;

@end

@implementation SSJsonSerializerTests

- (void)setUp {
    [super setUp];
    expectedJsonInput = @"[{\"city\":\"Washington\",\"state\":\"District of Columbia\",\"zipcode\":\"20500\"},{\"city\":\"Provo\",\"state\":\"Utah\"},{\"zipcode\":\"54321\"}]";
    _serializer = [[SSJsonSerializer alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSerializationOfNullValues {
    NSMutableData *results = [self.serializer serialize:nil];
    
    XCTAssertNil(results);
}

- (void)testSerializationOfKnownType {
    NSString *jsonString = @"{\"Property2\":42,\"Property3\":true,\"property_1\":\"Name\"}";
    NSData *expectedJson = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    StringProperty *stringProperty = [[StringProperty alloc] initWithName:@"Name"];
//    IntProperty *intProperty = [[IntProperty alloc] initWithNumber:42];
//    BoolProperty *boolProperty = [[BoolProperty alloc] initWithBooleanValue:true];
    
//    NSMutableArray *lookups = [[NSMutableArray alloc] init];
//    [lookups addObject:stringProperty];
//    [lookups addObject:intProperty];
//    [lookups addObject:boolProperty];
//    NSMutableData *lookupBytes = [self.serializer serialize:lookups];
    
    NSMutableDictionary *testLookups = [[NSMutableDictionary alloc] init];
    [testLookups setValue:@"name" forKey:@"Property1"];
    [testLookups setValue:@42 forKey:@"Property2"];
    [testLookups setValue:@YES forKey:@"Property3"];
    NSMutableData *lookupBytes = [self.serializer serialize:testLookups];
    
    XCTAssertEqual(expectedJson, lookupBytes);
}

- (void)testDeserializationOfNullStream {
    
}

- (void)testDeserializationOfKnownType {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    
    NSData *expectedJson = [expectedJsonInput dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *json = [NSMutableData dataWithData:expectedJson];
    NSArray *results = [serializer deserialize:json withClassType:[SSResult class] error:&error];
    
    SSResult *result = [[SSResult alloc] initWithData:[results objectAtIndex:0]];
    
    XCTAssertNotNil([results objectAtIndex:0]);
}

@end
