#import <XCTest/XCTest.h>
#import "SSJsonSerializer.h"
#import "SSStreetLookup.h"
#import "SSCandidate.h"

@interface SSJsonSerializerTestsForUSStreet : XCTestCase {
    NSArray *expectedJsonInput;
    NSArray *expectedJsonOutputValid;
    NSArray *expectedJsonOutputInvalid;
}

@property (readonly, nonatomic) SSJsonSerializer *serializer;

@end

@implementation SSJsonSerializerTestsForUSStreet

- (void)setUp {
    [super setUp];
    expectedJsonInput = @[
                          @{
                              @"street": @"street_value",
                              @"street2": @"street2_value",
                              @"secondary": @"secondary_value",
                              @"city": @"city_value",
                              @"state": @"state_value",
                              @"zipcode": @"zipCode_value",
                              @"lastline": @"lastline_value",
                              @"addressee": @"addressee_value",
                              @"urbanization": @"urbanization_value",
                              @"candidates" :@5
                              },
                          @{
                              @"street": @"1600 amphitheatre parkway",
                              @"city": @"Mountain view",
                              @"state": @"California",
                              @"candidates": @1
                              },
                          @{
                              @"street": @"1 Rosedale, Baltimore, Maryland",
                              @"candidates": @1
                              }
                          ];
    
    expectedJsonOutputValid = @[@{@"input_id":@"inputId1",@"input_index":@0,@"candidate_index":@0,@"addressee":@"addressee1",@"delivery_line_1":@"1 Santa Claus Ln",@"delivery_line_2":@"2 Santa Claus St",@"last_line":@"North Pole AK 99705-9901",@"delivery_point_barcode":@"997059901010",@"components":@{@"urbanization":@"12345",@"primary_number":@"1",@"street_name":@"Santa Claus",@"street_predirection":@"pre",@"street_postdirection":@"post",@"street_suffix":@"Ln",@"secondary_number":@"2345",@"secondary_designator":@"secondaryDesignator1",@"extra_secondary_number":@"extraSecondaryNumber1",@"extra_secondary_designator":@"extraSecondaryDesignator",@"pmb_designator":@"pmbDesignator",@"pmb_number":@"pmbNumber",@"city_name":@"North Pole",@"default_city_name":@"defaultCityName",@"state_abbreviation":@"AK",@"zipcode":@"99705",@"plus4_code":@"9901",@"delivery_point":@"01",@"delivery_point_check_digit":@"0"},@"metadata":@{@"record_type":@"S",@"zip_type":@"Standard",@"county_fips":@"02090",@"county_name":@"Fairbanks North Star",@"carrier_route":@"C004",@"congressional_district":@"AL",@"building_default_indicator":@"buildingDefaultIndicator",@"rdi":@"Commercial",@"elot_sequence":@"0001",@"elot_sort":@"A",@"latitude":@64.75233,@"longitude":@-147.35297,@"precision":@"Zip8",@"time_zone":@"Alaska",@"utc_offset":@-9,@"dst":@YES},@"analysis":@{@"dpv_match_code":@"Y",@"dpv_footnotes":@"AABB",@"dpv_cmra":@"N",@"dpv_vacant":@"N",@"active":@"Y",@"ews_match":@YES,@"footnotes":@"L#",@"lacslink_code":@"lacslinkCode",@"lacslink_indicator":@"lacslinkIndicator",@"suitelink_match":@YES}},@{@"input_id":@"inputId2",@"input_index":@1,@"candidate_index":@1,@"addressee":@"Apple Inc",@"delivery_line_1":@"1 Infinite Loop",@"delivery_line_2":@"2 Finite Loop",@"last_line":@"Finite Loop 99705-9901",@"delivery_point_barcode":@"753625901010",@"components":@{@"urbanization":@"54321",@"primary_number":@"2",@"street_name":@"Claus",@"street_predirection":@"pre2",@"street_postdirection":@"post2",@"street_suffix":@"Ln2",@"secondary_number":@"6543",@"secondary_designator":@"secondaryDesignator2",@"extra_secondary_number":@"extraSecondaryNumber2",@"extra_secondary_designator":@"extraSecondaryDesignator2",@"pmb_designator":@"pmbDesignator2",@"pmb_number":@"pmbNumber2",@"city_name":@"North2",@"default_city_name":@"defaultCityName2",@"state_abbreviation":@"AK2",@"zipcode":@"81345",@"plus4_code":@"925",@"delivery_point":@"02",@"delivery_point_check_digit":@"2"},@"metadata":@{@"record_type":@"N",@"zip_type":@"Standard2",@"county_fips":@"2345",@"county_name":@"Fairbanks2",@"carrier_route":@"B004",@"congressional_district":@"NV2",@"building_default_indicator":@"buildingDefaultIndicator2",@"rdi":@"Commercial2",@"elot_sequence":@"235",@"elot_sort":@"B",@"latitude":@75.7523,@"longitude":@-135.3597,@"precision":@"Zip2",@"time_zone":@"Alaska2",@"utc_offset":@-82,@"dst":@NO},@"analysis":@{@"dpv_match_code":@"N",@"dpv_footnotes":@"BBCC",@"dpv_cmra":@"Y",@"dpv_vacant":@"Y",@"active":@"N",@"ews_match":@NO,@"footnotes":@"N#",@"lacslink_code":@"lacslinkCode2",@"lacslink_indicator":@"lacslinkIndicator2",@"suitelink_match":@NO}}];
    
    expectedJsonOutputInvalid = @[]; //don't change this is the way it's suppose to be
    
    _serializer = [[SSJsonSerializer alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSerializationOfKnownType {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    NSMutableArray *lookups = [NSMutableArray new];
    
    SSStreetLookup *lookup1 = [[SSStreetLookup alloc] init];
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
//    lookup1.match = @"match_value"; //TODO: should one be tested with match?
    
    SSStreetLookup *lookup2 = [[SSStreetLookup alloc] init];
    lookup2.street = @"1600 amphitheatre parkway";
    lookup2.city = @"Mountain view";
    lookup2.state = @"California";
    
    [lookups addObject:lookup1];
    [lookups addObject:lookup2];
    [lookups addObject:[[SSStreetLookup alloc] initWithFreeformAddress:@"1 Rosedale, Baltimore, Maryland"]];
    
    NSData *actualBytes = [serializer serialize:lookups withClassType:[SSStreetLookup class] error:&error];
    NSArray *actualArray = [NSJSONSerialization JSONObjectWithData:actualBytes options:kNilOptions error:&error];
    
    NSData *expectedBytes = [NSJSONSerialization dataWithJSONObject:expectedJsonInput options:kNilOptions error:&error];
    NSArray *expectedArray = [NSJSONSerialization JSONObjectWithData:expectedBytes options:kNilOptions error:&error];
    
    XCTAssertNotNil(actualBytes);
    XCTAssertTrue([actualArray isEqualToArray:expectedArray]);
}

- (void)testDeserializationOfInvalidType {
    
}

- (void)testDeserializationOfValidType {
    SSJsonSerializer *serializer = [[SSJsonSerializer alloc] init];
    NSError *error = nil;
    
    NSData *expectedJson = [NSJSONSerialization dataWithJSONObject:expectedJsonOutputValid options:NSJSONWritingPrettyPrinted error:&error];
    NSArray<SSCandidate*> *candidates = [serializer deserialize:expectedJson withClassType:[SSCandidate class] error:&error];
    
    XCTAssertNotNil(candidates);
    
    //Candidate1
    XCTAssertNotNil([candidates objectAtIndex:0]);
    SSCandidate *candidate1 = [candidates objectAtIndex:0];
    XCTAssertEqualObjects(@"inputId1", candidate1.inputId);
    XCTAssertEqual(0, candidate1.inputIndex);
    XCTAssertEqual(0, candidate1.candidateIndex);
    XCTAssertEqualObjects(@"addressee1", candidate1.addressee);
    XCTAssertEqualObjects(@"1 Santa Claus Ln", candidate1.deliveryLine1);
    XCTAssertEqualObjects(@"2 Santa Claus St", candidate1.deliveryLine2);
    XCTAssertEqualObjects(@"North Pole AK 99705-9901", candidate1.lastline);
    XCTAssertEqualObjects(@"997059901010", candidate1.deliveryPointBarcode);
    
    //Candidate1 Components
    XCTAssertNotNil(candidate1.components);
    XCTAssertEqualObjects(@"12345", candidate1.components.urbanization);
    XCTAssertEqualObjects(@"1", candidate1.components.primaryNumber);
    XCTAssertEqualObjects(@"Santa Claus", candidate1.components.streetName);
    XCTAssertEqualObjects(@"pre", candidate1.components.streetPredirection);
    XCTAssertEqualObjects(@"post", candidate1.components.streetPostdirection);
    XCTAssertEqualObjects(@"Ln", candidate1.components.streetSuffix);
    XCTAssertEqualObjects(@"2345", candidate1.components.secondaryNumber);
    XCTAssertEqualObjects(@"secondaryDesignator1", candidate1.components.secondaryDesignator);
    XCTAssertEqualObjects(@"extraSecondaryNumber1", candidate1.components.extraSecondaryNumber);
    XCTAssertEqualObjects(@"extraSecondaryDesignator", candidate1.components.extraSecondaryDesignator);
    XCTAssertEqualObjects(@"pmbDesignator", candidate1.components.pmbDesignator);
    XCTAssertEqualObjects(@"pmbNumber", candidate1.components.pmbNumber);
    XCTAssertEqualObjects(@"North Pole", candidate1.components.cityName);
    XCTAssertEqualObjects(@"defaultCityName", candidate1.components.defaultCityName);
    XCTAssertEqualObjects(@"AK", candidate1.components.state);
    XCTAssertEqualObjects(@"99705", candidate1.components.zipCode);
    XCTAssertEqualObjects(@"9901", candidate1.components.plus4Code);
    XCTAssertEqualObjects(@"01", candidate1.components.deliveryPoint);
    XCTAssertEqualObjects(@"0", candidate1.components.deliveryPointCheckDigit);
    
    //Candidate1 Metadata
    XCTAssertNotNil(candidate1.metadata);
    XCTAssertEqualObjects(@"S", candidate1.metadata.recordType);
    XCTAssertEqualObjects(@"Standard", candidate1.metadata.zipType);
    XCTAssertEqualObjects(@"02090", candidate1.metadata.countyFips);
    XCTAssertEqualObjects(@"Fairbanks North Star", candidate1.metadata.countyName);
    XCTAssertEqualObjects(@"C004", candidate1.metadata.carrierRoute);
    XCTAssertEqualObjects(@"AL", candidate1.metadata.congressionalDistrict);
    XCTAssertEqualObjects(@"buildingDefaultIndicator", candidate1.metadata.buildingDefaultIndicator);
    XCTAssertEqualObjects(@"Commercial", candidate1.metadata.rdi);
    XCTAssertEqualObjects(@"0001", candidate1.metadata.elotSequence);
    XCTAssertEqualObjects(@"A", candidate1.metadata.elotSort);
    XCTAssertEqual(64.75233, candidate1.metadata.latitude);
    XCTAssertEqual(-147.35297, candidate1.metadata.longitude);
    XCTAssertEqualObjects(@"Zip8", candidate1.metadata.precision);
    XCTAssertEqualObjects(@"Alaska", candidate1.metadata.timeZone);
    XCTAssertEqual(-9, candidate1.metadata.utcOffset);
    XCTAssertTrue(candidate1.metadata.obeysDst);
    
    //Candidate1 Analysis
    XCTAssertEqualObjects(@"Y", candidate1.analysis.dpvMatchCode);
    XCTAssertEqualObjects(@"AABB", candidate1.analysis.dpvFootnotes);
    XCTAssertEqualObjects(@"N", candidate1.analysis.cmra);
    XCTAssertEqualObjects(@"N", candidate1.analysis.vacant);
    XCTAssertEqualObjects(@"Y", candidate1.analysis.active);
    XCTAssertTrue(candidate1.analysis.isEwsMatch);
    XCTAssertEqualObjects(@"L#", candidate1.analysis.footnotes);
    XCTAssertEqualObjects(@"lacslinkCode", candidate1.analysis.lacsLinkCode);
    XCTAssertEqualObjects(@"lacslinkIndicator", candidate1.analysis.lacsLinkIndicator);
    XCTAssertTrue(candidate1.analysis.isSuiteLinkMatch);
    
    //Candidate2
    XCTAssertNotNil([candidates objectAtIndex:1]);
    SSCandidate *candidate2 = [candidates objectAtIndex:1];
    XCTAssertEqualObjects(@"inputId2", candidate2.inputId);
    XCTAssertEqual(1, candidate2.inputIndex);
    XCTAssertEqual(1, candidate2.candidateIndex);
    XCTAssertEqualObjects(@"Apple Inc", candidate2.addressee);
    XCTAssertEqualObjects(@"1 Infinite Loop", candidate2.deliveryLine1);
    XCTAssertEqualObjects(@"2 Finite Loop", candidate2.deliveryLine2);
    XCTAssertEqualObjects(@"Finite Loop 99705-9901", candidate2.lastline);
    XCTAssertEqualObjects(@"753625901010", candidate2.deliveryPointBarcode);
    
    //Candidate2 Components
    XCTAssertEqualObjects(@"pre2", candidate2.components.streetPredirection);
    XCTAssertEqualObjects(@"pmbNumber2", candidate2.components.pmbNumber);
    XCTAssertEqualObjects(@"02", candidate2.components.deliveryPoint);
    
    //Candidate2 Metadata
    XCTAssertEqualObjects(@"N", candidate2.metadata.recordType);
    XCTAssertEqual(75.7523, candidate2.metadata.latitude);
    XCTAssertFalse(candidate2.metadata.obeysDst);
    
    //Candidate2 Analysis
    XCTAssertEqualObjects(@"N", candidate2.analysis.dpvMatchCode);
    XCTAssertFalse(candidate2.analysis.isEwsMatch);
    XCTAssertEqualObjects(@"lacslinkIndicator2", candidate2.analysis.lacsLinkIndicator);
    XCTAssertFalse(candidate2.analysis.isSuiteLinkMatch);
}

@end
