#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"
#import "SSUSZipCodeLookup.h"
#import "SSUSZipCodeResult.h"

@interface SSUSZipCodeResultTests : XCTestCase {
    NSArray *expectedJsonInput;
    NSDictionary *obj;
}

@property (nonatomic) SSUSZipCodeResult *result;

@end

@implementation SSUSZipCodeResultTests

- (void)setUp {
    [super setUp];
    _result = [[SSUSZipCodeResult alloc] init];
    
    expectedJsonInput = @[@{@"city":@"Las Vegas",@"state":@"NV",@"zipcode":@"12345"},@{@"city":@"Provo",@"state":@"Utah"},@{@"zipcode":@"54321"}];
    
    obj = @{
            @"status": @"0",
            @"reason": @"1",
            @"input_index": [NSNumber numberWithInteger:2],
            @"city_states": [NSArray arrayWithObjects:
                             @{
                    @"city": @"3",
                    @"mailable_city": @YES,
                    @"state_abbreviation": @"4",
                    @"state": @"5"
                }, nil],
            @"zipcodes": [NSArray arrayWithObjects:
                          @{
                    @"zipcode": @"6",
                    @"zipcode_type": @"7",
                    @"default_city": @"8",
                    @"county_fips": @"9",
                    @"county_name": @"10",
                    @"state_abbreviation": @"11",
                    @"state": @"12",
                    @"latitude": [NSNumber numberWithInteger:13],
                    @"longitude": [NSNumber numberWithInteger:14],
                    @"precision": @"15",
                    @"alternate_counties": [NSArray arrayWithObjects:
                                            @{
                                @"county_fips": @"16",
                                @"county_name": @"17",
                                @"state_abbreviation": @"18",
                                @"state": @"19"
                            }, nil]
                }, nil]
            };
}

- (void)tearDown {
    [super tearDown];
}

- (void)testIsValidReturnsTrueWhenInputIsValid {
    XCTAssertTrue([self.result isValid]);
}

- (void)testIsValidReturnsFalseWhenInputIsNotValid {
    self.result.status = @"invalid_zipcode";
    self.result.reason = @"invalid_reason";
    
    XCTAssertEqual(false, [self.result isValid]);
}

- (void)testSerializationOfKnownType {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    NSMutableArray *lookups = [NSMutableArray new];
    [lookups addObject:[[SSUSZipCodeLookup alloc] initWithCity:@"Las Vegas" state:@"NV" zipcode:@"12345"]];
    [lookups addObject:[[SSUSZipCodeLookup alloc] initWithCity:@"Provo" state:@"Utah"]];
    [lookups addObject:[[SSUSZipCodeLookup alloc] initWithZipcode:@"54321"]];
    
    NSData *actualBytes = [serializer serialize:lookups withClassType:[SSUSZipCodeLookup class] error:&error];
    NSData *expectedBytes = [NSJSONSerialization dataWithJSONObject:expectedJsonInput options:kNilOptions error:&error];
    
    XCTAssertNotNil(actualBytes);
    XCTAssertTrue([expectedBytes isEqualToData:actualBytes]);
}

- (void)testAllFieldsFilledCorrectly {
    SSUSZipCodeResult *result = [[SSUSZipCodeResult alloc] initWithDictionary:obj];
    
    XCTAssertEqual(@"0", result.status);
    XCTAssertEqual(@"1", result.reason);
    XCTAssertEqual(2, result.inputIndex);
    
   SSUSCity *city = [result.cities objectAtIndex:0];
    XCTAssertEqual(@"3", city.city);
    XCTAssertTrue(city.mailableCity);
    XCTAssertEqual(@"4", city.stateAbbreviation);
    XCTAssertEqual(@"5", city.state);
    
    SSUSZipCode *zip = [result.zipCodes objectAtIndex:0];
    XCTAssertEqual(@"6", zip.zipCode);
    XCTAssertEqual(@"7", zip.zipCodeType);
    XCTAssertEqual(@"8", zip.defaultCity);
    XCTAssertEqual(@"9", zip.countyFips);
    XCTAssertEqual(@"10", zip.countyName);
    XCTAssertEqual(@"11", zip.stateAbbreviation);
    XCTAssertEqual(@"12", zip.state);
    XCTAssertEqual(13, zip.latitude);
    XCTAssertEqual(14, zip.longitude);
    XCTAssertEqual(@"15", zip.precision);
    
    SSUSAlternateCounties *altCounties = [zip.alternateCounties objectAtIndex:0];
    XCTAssertEqual(@"16", altCounties.countyFips);
    XCTAssertEqual(@"17", altCounties.countyName);
    XCTAssertEqual(@"18", altCounties.stateAbbreviation);
    XCTAssertEqual(@"19", altCounties.state);
}

- (void)testWhenZipCodesAndCitiesAreNullCreatesNewNSMutableArray {
    NSNull *nullObj = [NSNull null];
    obj = @{
            @"zipcodes": nullObj,
            @"city_states": nullObj
            };
    SSUSZipCodeResult *result = [[SSUSZipCodeResult alloc] initWithDictionary:obj];
    XCTAssertNotNil(result.zipCodes);
    XCTAssertNotNil(result.cities);
}

- (void)testWhenAlternateCountiesIsNullCreatesNewNSMutableArray {
    NSNull *nullObj = [NSNull null];
    obj = @{
            @"alternate_counties": nullObj
            };
    SSUSZipCode *zipCode = [[SSUSZipCode alloc] initWithDictionary:obj];
    XCTAssertNotNil(zipCode.alternateCounties);
}

@end
