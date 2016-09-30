#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"
#import "SSZipCodeLookup.h"
#import "SSResult.h"

@interface SSJsonSerializerTests : XCTestCase {
    NSString *expectedJsonInput;
    NSString *expectedJsonOutput;
}

@property (readonly, nonatomic) SSJsonSerializer *serializer;

@end

@implementation SSJsonSerializerTests

- (void)setUp {
    [super setUp];
    expectedJsonInput = @"[{\"city\":\"Washington\",\"state\":\"District of Columbia\",\"zipcode\":\"20500\"},{\"city\":\"Provo\",\"state\":\"Utah\"},{\"zipcode\":\"54321\"}]";
    expectedJsonOutput = @"[{\"input_index\":0,\"city_states\":[{\"city\":\"city1\",\"state_abbreviation\":\"CA\",\"state\":\"state1\",\"mailable_city\":true},{\"city\":\"city2\",\"state_abbreviation\":\"NV\",\"state\":\"state2\",\"mailable_city\":false}],\"zipcodes\":[{\"zipcode\":\"12345\",\"zipcode_type\":\"S\",\"default_city\":\"Los Angeles\",\"county_fips\":\"06037\",\"county_name\":\"Los Angeles\",\"state_abbreviation\":\"CA\",\"state\":\"California\",\"latitude\":34.02425,\"longitude\":-118.20399,\"precision\":\"Zip5\"},{\"zipcode\":\"56789\",\"zipcode_type\":\"S\",\"default_city\":\"Los Vegas\",\"county_fips\":\"34567\",\"county_name\":\"Los Vegas\",\"state_abbreviation\":\"NV\",\"state\":\"Nevada\",\"latitude\":35.02437,\"longitude\":-115.20356,\"precision\":\"Zip5\"}]},{\"input_index\":1,\"city_states\":[{\"city\":\"Provo\",\"state_abbreviation\":\"UT\",\"state\":\"Utah\",\"default_city\":true,\"mailable_city\":true}],\"zipcodes\":[{\"zipcode\":\"84606\",\"zipcode_type\":\"S\",\"county_fips\":\"11501\",\"county_name\":\"Utah\",\"latitude\":38.89769,\"longitude\":-77.038}]},{\"input_index\":2,\"status\":\"invalid_zipcode\",\"reason\":\"Invalid ZIP Code.\"}]";
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
    
    NSData *expectedJson = [expectedJsonOutput dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *json = [NSMutableData dataWithData:expectedJson];
    NSArray<SSResult*> *results = [serializer deserialize:json withClassType:[SSResult class] error:&error];
    
    //Result1
    XCTAssertNotNil([results objectAtIndex:0]);
    SSResult *result1 = [results objectAtIndex:0];
    XCTAssertEqual(0, [[results objectAtIndex:0] inputIndex]);
    
    XCTAssertNotNil([result1 getCityAtIndex:0]);
    XCTAssertEqualObjects(@"city1", [[result1 getCityAtIndex:0] city]);
    XCTAssertEqualObjects(@"CA", [[result1 getCityAtIndex:0] stateAbbreviation]);
    XCTAssertEqualObjects(@"state1", [[result1 getCityAtIndex:0] state]);
    XCTAssertTrue([[result1 getCityAtIndex:0] mailableCity]);
    XCTAssertNotNil([result1 getCityAtIndex:1]);
    XCTAssertEqualObjects(@"state2", [[result1 getCityAtIndex:1] state]);
    XCTAssertFalse([[result1 getCityAtIndex:1] mailableCity]); //TODO: should default be true, false or nil?
    
    XCTAssertNotNil([result1 getZipCodeAtIndex:0]);
    XCTAssertEqualObjects(@"12345", [[result1 getZipCodeAtIndex:0] zipCode]);
    XCTAssertEqualObjects(@"S", [[result1 getZipCodeAtIndex:0] zipCodeType]);
    XCTAssertEqualObjects(@"Los Angeles", [[result1 getZipCodeAtIndex:0] defaultCity]);
    XCTAssertEqualObjects(@"06037", [[result1 getZipCodeAtIndex:0] countyFips]);
    XCTAssertEqualObjects(@"Los Angeles", [[result1 getZipCodeAtIndex:0] countyName]);
    XCTAssertEqualObjects(@"CA", [[result1 getZipCodeAtIndex:0] stateAbbreviation]);
    XCTAssertEqualObjects(@"California", [[result1 getZipCodeAtIndex:0] state]);
    XCTAssertEqual(34.02425, [[result1 getZipCodeAtIndex:0] latitude]);
    XCTAssertEqual(-118.20399, [[result1 getZipCodeAtIndex:0] longitude]);
    XCTAssertEqualObjects(@"Zip5", [[result1 getZipCodeAtIndex:0] precision]);
    XCTAssertNotNil([result1 getZipCodeAtIndex:1]);
    XCTAssertEqualObjects(@"56789", [[result1 getZipCodeAtIndex:1] zipCode]);
    XCTAssertEqualObjects(@"Los Vegas", [[result1 getZipCodeAtIndex:1] defaultCity]);
    XCTAssertEqual(35.02437, [[result1 getZipCodeAtIndex:1] latitude]);
    
    //Result2
    XCTAssertNotNil([results objectAtIndex:1]);
    SSResult *result2 = [results objectAtIndex:1];
    XCTAssertEqual(1, [[results objectAtIndex:1] inputIndex]);
    
//    XCTAssertNotNil([result1 getCityAtIndex:0]);
//    XCTAssertEqualObjects(@"city1", [[result1 getCityAtIndex:0] city]);
//    XCTAssertEqualObjects(@"CA", [[result1 getCityAtIndex:0] stateAbbreviation]);
//    XCTAssertEqualObjects(@"state1", [[result1 getCityAtIndex:0] state]);
//    XCTAssertTrue([[result1 getCityAtIndex:0] mailableCity]);
//    XCTAssertNotNil([result1 getCityAtIndex:1]);
//    XCTAssertEqualObjects(@"state2", [[result1 getCityAtIndex:1] state]);
//    XCTAssertFalse([[result1 getCityAtIndex:1] mailableCity]);
    
}

@end
