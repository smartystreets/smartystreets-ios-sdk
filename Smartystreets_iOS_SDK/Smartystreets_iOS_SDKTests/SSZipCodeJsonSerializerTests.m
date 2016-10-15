#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"
#import "SSZipCodeLookup.h"
#import "SSResult.h"

@interface SSJsonSerializerTests : XCTestCase {
    NSArray *expectedJsonInput;
    NSArray *expectedJsonOutput;
}

@property (readonly, nonatomic) SSJsonSerializer *serializer;

@end

@implementation SSJsonSerializerTests

- (void)setUp {
    [super setUp];
    expectedJsonInput = @[@{@"city":@"Las Vegas",@"state":@"NV",@"zipcode":@"12345"},@{@"city":@"Provo",@"state":@"Utah"},@{@"zipcode":@"54321"}];

    expectedJsonOutput = @[@{@"input_index":@0,@"city_states":@[@{@"city":@"city1",@"state_abbreviation":@"CA",@"state":@"state1",@"mailable_city":@YES},@{@"city":@"city2",@"state_abbreviation":@"NV",@"state":@"state2",@"mailable_city":@NO}],@"zipcodes":@[@{@"zipcode":@"12345",@"zipcode_type":@"S",@"default_city":@"Los Angeles",@"county_fips":@"06037",@"county_name":@"Los Angeles",@"state_abbreviation":@"CA",@"state":@"California",@"latitude":@34.02425,@"longitude":@-118.20399,@"precision":@"Zip5",@"alternate_counties":@[@{@"county_fips":@"21047",@"county_name":@"Christian",@"state_abbreviation":@"KY",@"state":@"Kentucky"},@{@"county_fips":@"47125",@"county_name":@"Montgomery",@"state_abbreviation":@"TN",@"state":@"Tennessee"}]},@{@"zipcode":@"56789",@"zipcode_type":@"S",@"default_city":@"Los Vegas",@"county_fips":@"34567",@"county_name":@"Los Vegas",@"state_abbreviation":@"NV",@"state":@"Nevada",@"latitude":@35.02437,@"longitude":@-115.20356,@"precision":@"Zip5"}]},@{@"input_index":@1,@"city_states":@[@{@"city":@"Provo",@"state_abbreviation":@"UT",@"state":@"Utah",@"mailable_city":@YES}],@"zipcodes":@[@{@"zipcode":@"84606",@"zipcode_type":@"S",@"county_fips":@"11501",@"county_name":@"Utah",@"latitude":@38.89769,@"longitude":@-77.038,@"alternate_counties":@[@{@"county_fips":@"23456",@"county_name":@"County",@"state_abbreviation":@"AZ",@"state":@"Arizona"}]}]},@{@"input_index":@2,@"status":@"invalid_zipcode",@"reason":@"Invalid ZIP Code."}];
    
    _serializer = [[SSJsonSerializer alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSerializationOfNullValues {
    NSError *error = nil;
    NSData *results = [self.serializer serialize:nil withClassType:nil error:&error];
    
    XCTAssertNil(results);
}

- (void)testSerializationOfKnownType {
    NSError *error = nil;
    NSMutableArray *lookups = [NSMutableArray new];
    [lookups addObject:[[SSZipCodeLookup alloc] initWithCity:@"Las Vegas" state:@"NV" zipcode:@"12345"]];
    [lookups addObject:[[SSZipCodeLookup alloc] initWithCity:@"Provo" state:@"Utah"]];
    [lookups addObject:[[SSZipCodeLookup alloc] initWithZipcode:@"54321"]];
    
    NSData *actualBytes = [_serializer serialize:lookups withClassType:[SSZipCodeLookup class] error:&error];
    NSData *expectedBytes = [NSJSONSerialization dataWithJSONObject:expectedJsonInput options:kNilOptions error:&error];
    
    XCTAssertNotNil(actualBytes);
    XCTAssertTrue([expectedBytes isEqualToData:actualBytes]);
}

- (void)testDeserializationOfNullStream {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    NSArray *result = [serializer deserialize:nil withClassType:nil error:&error];
    
    XCTAssertNil(result);
}

- (void)testDeserializationOfKnownType {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    
    NSData *expectedJson = [NSJSONSerialization dataWithJSONObject:expectedJsonOutput options:NSJSONWritingPrettyPrinted error:&error];
    NSArray<SSResult*> *results = [serializer deserialize:expectedJson withClassType:[SSResult class] error:&error];
    
    XCTAssertNotNil(results);
    
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
    XCTAssertFalse([[result1 getCityAtIndex:1] mailableCity]);
    
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
    XCTAssertEqualObjects(@"21047", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] countyFips]);
    XCTAssertEqualObjects(@"Christian", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] countyName]);
    XCTAssertEqualObjects(@"KY", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] stateAbbreviation]);
    XCTAssertEqualObjects(@"Kentucky", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] state]);
    XCTAssertEqualObjects(@"47125", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:1] countyFips]);
    XCTAssertEqualObjects(@"Montgomery", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:1] countyName]);
    XCTAssertEqualObjects(@"TN", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:1] stateAbbreviation]);
    XCTAssertEqualObjects(@"Tennessee", [[[result1 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:1] state]);
    
    XCTAssertNotNil([result1 getZipCodeAtIndex:1]);
    XCTAssertEqualObjects(@"56789", [[result1 getZipCodeAtIndex:1] zipCode]);
    XCTAssertEqualObjects(@"Los Vegas", [[result1 getZipCodeAtIndex:1] defaultCity]);
    XCTAssertEqual(35.02437, [[result1 getZipCodeAtIndex:1] latitude]);
    
    //Result2
    XCTAssertNotNil([results objectAtIndex:1]);
    SSResult *result2 = [results objectAtIndex:1];
    XCTAssertEqual(1, [[results objectAtIndex:1] inputIndex]);
    XCTAssertEqualObjects(@"UT", [[result2 getCityAtIndex:0] stateAbbreviation]);
    XCTAssertEqualObjects(@"Utah", [[result2 getCityAtIndex:0] state]);
    XCTAssertTrue([[result2 getCityAtIndex:0] mailableCity]);
    XCTAssertEqualObjects(@"84606", [[result2 getZipCodeAtIndex:0] zipCode]);
    XCTAssertEqualObjects(@"S", [[result2 getZipCodeAtIndex:0] zipCodeType]);
    XCTAssertEqualObjects(@"11501", [[result2 getZipCodeAtIndex:0] countyFips]);
    XCTAssertEqualObjects(@"Utah", [[result2 getZipCodeAtIndex:0] countyName]);
    XCTAssertEqual(38.89769, [[result2 getZipCodeAtIndex:0] latitude]);
    XCTAssertEqual(-77.038, [[result2 getZipCodeAtIndex:0] longitude]);
    XCTAssertEqualObjects(@"23456", [[[result2 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] countyFips]);
    XCTAssertEqualObjects(@"County", [[[result2 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] countyName]);
    XCTAssertEqualObjects(@"AZ", [[[result2 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] stateAbbreviation]);
    XCTAssertEqualObjects(@"Arizona", [[[result2 getZipCodeAtIndex:0] getAlternateCountiesAtIndex:0] state]);
    
    //Result3
    XCTAssertNotNil([results objectAtIndex:2]);
    XCTAssertEqualObjects(@"invalid_zipcode", [[results objectAtIndex:2] status]);
    XCTAssertEqualObjects(@"Invalid ZIP Code.", [[results objectAtIndex:2] reason]);
}

@end
