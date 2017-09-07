#import <XCTest/XCTest.h>
#import "SSInternationalStreetCandidate.h"

@interface SSInternationalStreetCandidateTests : XCTestCase {
    NSDictionary *obj;
}

@end

@implementation SSInternationalStreetCandidateTests

- (void)setUp {
    [super setUp];
    
    obj = @{
            @"organization": @"1",
            @"address1": @"2",
            @"address2": @"3",
            @"address3": @"4",
            @"address4": @"5",
            @"address5": @"6",
            @"address6": @"7",
            @"address7": @"8",
            @"address8": @"9",
            @"address9": @"10",
            @"address10": @"11",
            @"address11": @"12",
            @"address12": @"13",
            @"components": @{
                    @"country_iso_3": @"14",
                    @"super_administrative_area": @"15",
                    @"administrative_area": @"16",
                    @"sub_administrative_area": @"17",
                    @"dependent_locality": @"18",
                    @"dependent_locality_name": @"19",
                    @"double_dependent_locality": @"20",
                    @"locality": @"21",
                    @"postal_code": @"22",
                    @"postal_code_short": @"23",
                    @"postal_code_extra": @"24",
                    @"premise": @"25",
                    @"premise_extra": @"26",
                    @"premise_number": @"27",
                    @"premise_type": @"28",
                    @"thoroughfare": @"29",
                    @"thoroughfare_predirection": @"30",
                    @"thoroughfare_postdirection": @"31",
                    @"thoroughfare_name": @"32",
                    @"thoroughfare_trailing_type": @"33",
                    @"thoroughfare_type": @"34",
                    @"dependent_thoroughfare": @"35",
                    @"dependent_thoroughfare_predirection": @"36",
                    @"dependent_thoroughfare_postdirection": @"37",
                    @"dependent_thoroughfare_name": @"38",
                    @"dependent_thoroughfare_trailing_type": @"39",
                    @"dependent_thoroughfare_type": @"40",
                    @"building": @"41",
                    @"building_leading_type": @"42",
                    @"building_name": @"43",
                    @"building_trailing_type": @"44",
                    @"sub_building_type": @"45",
                    @"sub_building_number": @"46",
                    @"sub_building_name": @"47",
                    @"sub_building": @"48",
                    @"post_box": @"49",
                    @"post_box_type": @"50",
                    @"post_box_number": @"51"
            },
            @"metadata": @{
                    @"latitude": [NSNumber numberWithDouble:52.0],
                    @"longitude": [NSNumber numberWithDouble:53.0],
                    @"geocode_precision": @"54",
                    @"max_geocode_precision": @"55",
                    @"address_format": @"56"
            },
            @"analysis": @{
                    @"verification_status": @"57",
                    @"address_precision": @"58",
                    @"max_address_precision": @"59"
            }
        };
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAllFieldsFilledCorrectly {
    SSInternationalStreetCandidate *candidate = [[SSInternationalStreetCandidate alloc] initWithDictionary:obj];
    
    XCTAssertEqual(@"1", candidate.organization);
    XCTAssertEqual(@"2", candidate.address1);
    XCTAssertEqual(@"3", candidate.address2);
    XCTAssertEqual(@"4", candidate.address3);
    XCTAssertEqual(@"5", candidate.address4);
    XCTAssertEqual(@"6", candidate.address5);
    XCTAssertEqual(@"7", candidate.address6);
    XCTAssertEqual(@"8", candidate.address7);
    XCTAssertEqual(@"9", candidate.address8);
    XCTAssertEqual(@"10", candidate.address9);
    XCTAssertEqual(@"11", candidate.address10);
    XCTAssertEqual(@"12", candidate.address11);
    XCTAssertEqual(@"13", candidate.address12);
    
    SSInternationalStreetComponents *components = candidate.components;
    XCTAssertNotNil(components);
    XCTAssertEqual(@"14", components.countryIso3);
    XCTAssertEqual(@"15", components.superAdministrativeArea);
    XCTAssertEqual(@"16", components.administrativeArea);
    XCTAssertEqual(@"17", components.subAdministrativeArea);
    XCTAssertEqual(@"18", components.dependentLocality);
    XCTAssertEqual(@"19", components.dependentLocalityName);
    XCTAssertEqual(@"20", components.doubleDependentLocality);
    XCTAssertEqual(@"21", components.locality);
    XCTAssertEqual(@"22", components.postalCode);
    XCTAssertEqual(@"23", components.postalCodeShort);
    XCTAssertEqual(@"24", components.postalCodeExtra);
    XCTAssertEqual(@"25", components.premise);
    XCTAssertEqual(@"26", components.premiseExtra);
    XCTAssertEqual(@"27", components.premiseNumber);
    XCTAssertEqual(@"28", components.premiseType);
    XCTAssertEqual(@"29", components.thoroughfare);
    XCTAssertEqual(@"30", components.thoroughfarePredirection);
    XCTAssertEqual(@"31", components.thoroughfarePostdirection);
    XCTAssertEqual(@"32", components.thoroughfareName);
    XCTAssertEqual(@"33", components.thoroughfareTrailingType);
    XCTAssertEqual(@"34", components.thoroughfareType);
    XCTAssertEqual(@"35", components.dependentThoroughfare);
    XCTAssertEqual(@"36", components.dependentThoroughfarePredirection);
    XCTAssertEqual(@"37", components.dependentThoroughfarePostdirection);
    XCTAssertEqual(@"38", components.dependentThoroughfareName);
    XCTAssertEqual(@"39", components.dependentThoroughfareTrailingType);
    XCTAssertEqual(@"40", components.dependentThoroughfareType);
    XCTAssertEqual(@"41", components.building);
    XCTAssertEqual(@"42", components.buildingLeadingType);
    XCTAssertEqual(@"43", components.buildingName);
    XCTAssertEqual(@"44", components.buildingTrailingType);
    XCTAssertEqual(@"45", components.subBuildingType);
    XCTAssertEqual(@"46", components.subBuildingNumber);
    XCTAssertEqual(@"47", components.subBuildingName);
    XCTAssertEqual(@"48", components.subBuilding);
    XCTAssertEqual(@"49", components.postBox);
    XCTAssertEqual(@"50", components.postBoxType);
    XCTAssertEqual(@"51", components.postBoxNumber);
    
    SSInternationalStreetMetadata *metadata = candidate.metadata;
    XCTAssertNotNil(metadata);
    XCTAssertEqual(52, metadata.latitude);
    XCTAssertEqual(53, metadata.longitude);
    XCTAssertEqual(@"54", metadata.geocodePrecision);
    XCTAssertEqual(@"55", metadata.maxGeocodePrecision);
    XCTAssertEqual(@"56", metadata.addressFormat);
    
    SSInternationalStreetAnalysis *analysis = candidate.analysis;
    XCTAssertNotNil(analysis);
    XCTAssertEqual(@"57", analysis.verificationStatus);
    XCTAssertEqual(@"58", analysis.addressPrecision);
    XCTAssertEqual(@"59", analysis.maxAddressPrecision);
}

@end
