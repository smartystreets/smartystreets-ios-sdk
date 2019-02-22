#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"
#import "SSUSStreetLookup.h"
#import "SSUSStreetCandidate.h"

@interface SSUSStreetCandidateTests : XCTestCase {
    NSArray *expectedJsonInput;
    NSDictionary *obj;
}

@end

@implementation SSUSStreetCandidateTests

- (void)setUp {
    [super setUp];
    expectedJsonInput = @[@{@"street":@"street_value",@"street2":@"street2_value",@"secondary":@"secondary_value",@"city":@"city_value",@"state":@"state_value",@"zipcode":@"zipCode_value",@"lastline":@"lastline_value",@"addressee":@"addressee_value",@"urbanization":@"urbanization_value",@"candidates":@5,@"match":@"match_value"},@{@"street":@"1600 amphitheatre parkway",@"city":@"Mountain view",@"state":@"California",@"candidates":@1},@{@"street":@"1 Rosedale, Baltimore, Maryland",@"candidates":@1}];
    
    obj = @{
            @"input_index": [NSNumber numberWithInteger:0],
            @"candidate_index": [NSNumber numberWithInteger:1],
            @"addressee": @"2",
            @"delivery_line_1": @"3",
            @"delivery_line_2": @"4",
            @"last_line": @"5",
            @"delivery_point_barcode": @"6",
            @"components": @{
                    @"urbanization": @"7",
                    @"primary_number": @"8",
                    @"street_name": @"9",
                    @"street_predirection": @"10",
                    @"street_postdirection": @"11",
                    @"street_suffix": @"12",
                    @"secondary_number": @"13",
                    @"secondary_designator": @"14",
                    @"extra_secondary_number": @"15",
                    @"extra_secondary_designator": @"16",
                    @"pmb_designator": @"17",
                    @"pmb_number": @"18",
                    @"city_name": @"19",
                    @"default_city_name": @"20",
                    @"state_abbreviation": @"21",
                    @"zipcode": @"22",
                    @"plus4_code": @"23",
                    @"delivery_point": @"24",
                    @"delivery_point_check_digit": @"25"
            },
            @"metadata": @{
                    @"record_type": @"26",
                    @"zip_type": @"27",
                    @"county_fips": @"28",
                    @"county_name": @"29",
                    @"carrier_route": @"30",
                    @"congressional_district": @"31",
                    @"building_default_indicator": @"32",
                    @"rdi": @"33",
                    @"elot_sequence": @"34",
                    @"elot_sort": @"35",
                    @"latitude": [NSNumber numberWithDouble:36.0],
                    @"longitude": [NSNumber numberWithDouble:37.0],
                    @"precision": @"38",
                    @"time_zone": @"39",
                    @"utc_offset": [NSNumber numberWithDouble:40.0],
                    @"dst": @YES,
                    @"ews_match": @YES
            },
            @"analysis": @{
                    @"dpv_match_code": @"42",
                    @"dpv_footnotes": @"43",
                    @"dpv_cmra": @"44",
                    @"dpv_vacant": @"45",
                    @"active": @"46",
                    @"ews_match": @YES,
                    @"footnotes": @"48",
                    @"lacslink_code": @"49",
                    @"lacslink_indicator": @"50",
                    @"suitelink_match": @YES
            }
           };
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSerializationOfKnownType {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    NSMutableArray *lookups = [NSMutableArray new];
    
    SSUSStreetLookup *lookup1 = [[SSUSStreetLookup alloc] init];
    lookup1.street = @"street_value";
    lookup1.street2 = @"street2_value";
    lookup1.secondary = @"secondary_value";
    lookup1.city = @"city_value";
    lookup1.state = @"state_value";
    lookup1.zipCode = @"zipCode_value";
    lookup1.lastline = @"lastline_value";
    lookup1.addressee = @"addressee_value";
    lookup1.urbanization = @"urbanization_value";
    [lookup1 setMaxCandidates:5 error:&error];
    lookup1.matchStrategy = @"match_value";
    
    SSUSStreetLookup *lookup2 = [[SSUSStreetLookup alloc] init];
    lookup2.street = @"1600 amphitheatre parkway";
    lookup2.city = @"Mountain view";
    lookup2.state = @"California";
    
    [lookups addObject:lookup1];
    [lookups addObject:lookup2];
    [lookups addObject:[[SSUSStreetLookup alloc] initWithFreeformAddress:@"1 Rosedale, Baltimore, Maryland"]];
    
    NSData *actualBytes = [serializer serialize:lookups withClassType:[SSUSStreetLookup class] error:&error];
    NSArray *actualArray = [NSJSONSerialization JSONObjectWithData:actualBytes options:kNilOptions error:&error];
    
    NSData *expectedBytes = [NSJSONSerialization dataWithJSONObject:expectedJsonInput options:kNilOptions error:&error];
    NSArray *expectedArray = [NSJSONSerialization JSONObjectWithData:expectedBytes options:kNilOptions error:&error];
    
    XCTAssertNotNil(actualBytes);
    XCTAssertTrue([actualArray isEqualToArray:expectedArray]);
}

- (void)testAllFieldsFilledCorrectly {
    SSUSStreetCandidate *candidate = [[SSUSStreetCandidate alloc] initWithDictionary:obj];
    
    XCTAssertEqual(0, candidate.inputIndex);
    XCTAssertEqual(1, candidate.candidateIndex);
    XCTAssertEqual(@"2", candidate.addressee);
    XCTAssertEqual(@"3", candidate.deliveryLine1);
    XCTAssertEqual(@"4", candidate.deliveryLine2);
    XCTAssertEqual(@"5", candidate.lastline);
    XCTAssertEqual(@"6", candidate.deliveryPointBarcode);
    
    SSUSStreetComponents *components = candidate.components;
    XCTAssertEqual(@"7", components.urbanization);
    XCTAssertEqual(@"8", components.primaryNumber);
    XCTAssertEqual(@"9", components.streetName);
    XCTAssertEqual(@"10", components.streetPredirection);
    XCTAssertEqual(@"11", components.streetPostdirection);
    XCTAssertEqual(@"12", components.streetSuffix);
    XCTAssertEqual(@"13", components.secondaryNumber);
    XCTAssertEqual(@"14", components.secondaryDesignator);
    XCTAssertEqual(@"15", components.extraSecondaryNumber);
    XCTAssertEqual(@"16", components.extraSecondaryDesignator);
    XCTAssertEqual(@"17", components.pmbDesignator);
    XCTAssertEqual(@"18", components.pmbNumber);
    XCTAssertEqual(@"19", components.cityName);
    XCTAssertEqual(@"20", components.defaultCityName);
    XCTAssertEqual(@"21", components.state);
    XCTAssertEqual(@"22", components.zipCode);
    XCTAssertEqual(@"23", components.plus4Code);
    XCTAssertEqual(@"24", components.deliveryPoint);
    XCTAssertEqual(@"25", components.deliveryPointCheckDigit);
    
    SSUSStreetMetadata *metadata = candidate.metadata;
    XCTAssertEqual(@"26", metadata.recordType);
    XCTAssertEqual(@"27", metadata.zipType);
    XCTAssertEqual(@"28", metadata.countyFips);
    XCTAssertEqual(@"29", metadata.countyName);
    XCTAssertEqual(@"30", metadata.carrierRoute);
    XCTAssertEqual(@"31", metadata.congressionalDistrict);
    XCTAssertEqual(@"32", metadata.buildingDefaultIndicator);
    XCTAssertEqual(@"33", metadata.rdi);
    XCTAssertEqual(@"34", metadata.elotSequence);
    XCTAssertEqual(@"35", metadata.elotSort);
    XCTAssertEqual(36, metadata.latitude);
    XCTAssertEqual(37, metadata.longitude);
    XCTAssertEqual(@"38", metadata.precision);
    XCTAssertEqual(@"39", metadata.timeZone);
    XCTAssertEqual(40, metadata.utcOffset);
    XCTAssertEqual(YES, metadata.obeysDst);
    XCTAssertEqual(YES, metadata.isEwsMatch);
    
    SSUSStreetAnalysis *analysis = candidate.analysis;
    XCTAssertEqual(@"42", analysis.dpvMatchCode);
    XCTAssertEqual(@"43", analysis.dpvFootnotes);
    XCTAssertEqual(@"44", analysis.cmra);
    XCTAssertEqual(@"45", analysis.vacant);
    XCTAssertEqual(@"46", analysis.active);
    XCTAssertEqual(@"48", analysis.footnotes);
    XCTAssertEqual(@"49", analysis.lacsLinkCode);
    XCTAssertEqual(@"50", analysis.lacsLinkIndicator);
    XCTAssertEqual(YES, analysis.isSuiteLinkMatch);
}

@end
