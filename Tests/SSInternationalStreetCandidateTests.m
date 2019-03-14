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
                    @"premise_prefix_number": @"27.5",
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
                    @"max_address_precision": @"59",
                    @"changes": @{
                            @"organization": @"60",
                            @"address1": @"61",
                            @"address2": @"62",
                            @"address3": @"63",
                            @"address4": @"64",
                            @"address5": @"65",
                            @"address6": @"66",
                            @"address7": @"67",
                            @"address8": @"68",
                            @"address9": @"69",
                            @"address10": @"70",
                            @"address11": @"71",
                            @"address12": @"72",
                            @"components": @{
                                    @"country_iso_3": @"73",
                                    @"super_administrative_area": @"74",
                                    @"administrative_area": @"75",
                                    @"sub_administrative_area": @"76",
                                    @"dependent_locality": @"77",
                                    @"dependent_locality_name": @"78",
                                    @"double_dependent_locality": @"79",
                                    @"locality": @"80",
                                    @"postal_code": @"81",
                                    @"postal_code_short": @"82",
                                    @"postal_code_extra": @"83",
                                    @"premise": @"84",
                                    @"premise_extra": @"85",
                                    @"premise_number": @"86",
                                    @"premise_prefix_number": @"87",
                                    @"premise_type": @"88",
                                    @"thoroughfare": @"89",
                                    @"thoroughfare_predirection": @"90",
                                    @"thoroughfare_postdirection": @"91",
                                    @"thoroughfare_name": @"92",
                                    @"thoroughfare_trailing_type": @"93",
                                    @"thoroughfare_type": @"94",
                                    @"dependent_thoroughfare": @"95",
                                    @"dependent_thoroughfare_predirection": @"96",
                                    @"dependent_thoroughfare_postdirection": @"97",
                                    @"dependent_thoroughfare_name": @"98",
                                    @"dependent_thoroughfare_trailing_type": @"99",
                                    @"dependent_thoroughfare_type": @"100",
                                    @"building": @"101",
                                    @"building_leading_type": @"102",
                                    @"building_name": @"103",
                                    @"building_trailing_type": @"104",
                                    @"sub_building_type": @"105",
                                    @"sub_building_number": @"106",
                                    @"sub_building_name": @"107",
                                    @"sub_building": @"108",
                                    @"post_box": @"109",
                                    @"post_box_type": @"110",
                                    @"post_box_number": @"111"
                                    }
                            }
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
    XCTAssertEqual(@"27.5", components.premisePrefixNumber);
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
    
    SSInternationalStreetChanges *changes = analysis.changes;
    XCTAssertNotNil(changes);
    XCTAssertEqual(@"60", changes.organization);
    XCTAssertEqual(@"61", changes.address1);
    XCTAssertEqual(@"62", changes.address2);
    XCTAssertEqual(@"63", changes.address3);
    XCTAssertEqual(@"64", changes.address4);
    XCTAssertEqual(@"65", changes.address5);
    XCTAssertEqual(@"66", changes.address6);
    XCTAssertEqual(@"67", changes.address7);
    XCTAssertEqual(@"68", changes.address8);
    XCTAssertEqual(@"69", changes.address9);
    XCTAssertEqual(@"70", changes.address10);
    XCTAssertEqual(@"71", changes.address11);
    XCTAssertEqual(@"72", changes.address12);
    
    SSInternationalStreetComponents *ccomponents = changes.components;
    XCTAssertNotNil(ccomponents);
    XCTAssertEqual(@"73", ccomponents.countryIso3);
    XCTAssertEqual(@"74", ccomponents.superAdministrativeArea);
    XCTAssertEqual(@"75", ccomponents.administrativeArea);
    XCTAssertEqual(@"76", ccomponents.subAdministrativeArea);
    XCTAssertEqual(@"77", ccomponents.dependentLocality);
    XCTAssertEqual(@"78", ccomponents.dependentLocalityName);
    XCTAssertEqual(@"79", ccomponents.doubleDependentLocality);
    XCTAssertEqual(@"80", ccomponents.locality);
    XCTAssertEqual(@"81", ccomponents.postalCode);
    XCTAssertEqual(@"82", ccomponents.postalCodeShort);
    XCTAssertEqual(@"83", ccomponents.postalCodeExtra);
    XCTAssertEqual(@"84", ccomponents.premise);
    XCTAssertEqual(@"85", ccomponents.premiseExtra);
    XCTAssertEqual(@"86", ccomponents.premiseNumber);
    XCTAssertEqual(@"87", ccomponents.premisePrefixNumber);
    XCTAssertEqual(@"88", ccomponents.premiseType);
    XCTAssertEqual(@"89", ccomponents.thoroughfare);
    XCTAssertEqual(@"90", ccomponents.thoroughfarePredirection);
    XCTAssertEqual(@"91", ccomponents.thoroughfarePostdirection);
    XCTAssertEqual(@"92", ccomponents.thoroughfareName);
    XCTAssertEqual(@"93", ccomponents.thoroughfareTrailingType);
    XCTAssertEqual(@"94", ccomponents.thoroughfareType);
    XCTAssertEqual(@"95", ccomponents.dependentThoroughfare);
    XCTAssertEqual(@"96", ccomponents.dependentThoroughfarePredirection);
    XCTAssertEqual(@"97", ccomponents.dependentThoroughfarePostdirection);
    XCTAssertEqual(@"98", ccomponents.dependentThoroughfareName);
    XCTAssertEqual(@"99", ccomponents.dependentThoroughfareTrailingType);
    XCTAssertEqual(@"100", ccomponents.dependentThoroughfareType);
    XCTAssertEqual(@"101", ccomponents.building);
    XCTAssertEqual(@"102", ccomponents.buildingLeadingType);
    XCTAssertEqual(@"103", ccomponents.buildingName);
    XCTAssertEqual(@"104", ccomponents.buildingTrailingType);
    XCTAssertEqual(@"105", ccomponents.subBuildingType);
    XCTAssertEqual(@"106", ccomponents.subBuildingNumber);
    XCTAssertEqual(@"107", ccomponents.subBuildingName);
    XCTAssertEqual(@"108", ccomponents.subBuilding);
    XCTAssertEqual(@"109", ccomponents.postBox);
    XCTAssertEqual(@"110", ccomponents.postBoxType);
    XCTAssertEqual(@"111", ccomponents.postBoxNumber);
}

@end
