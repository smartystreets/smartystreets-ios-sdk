#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSURLPrefixSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockSender.h"
#import "SSInternationalStreetClient.h"
#import "SSInternationalStreetLookup.h"


@interface SSInternationalClientTests : XCTestCase

@end

@implementation SSInternationalClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSendingFreeformLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:serializer];
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"freeform" withCountry:@"USA"];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(@"http://localhost/?country=USA&freeform=freeform", [capturingSender.request getUrl]);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:serializer];
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"freeform" withCountry:@"USA"];
    NSString *expectedUrl = @"http://localhost/?administrative_area=8&address1=2&geocode=true&address2=3&freeform=1&address3=4&address4=5&language=native&postal_code=9&country=0&locality=7&organization=6";
    NSError *error = nil;
    
    lookup.country = @"0";
    [lookup enableGeocode:YES];
    lookup.language = [[SSLanguageMode alloc] initWithName:kSSNative];
    lookup.freeform = @"1";
    lookup.address1 = @"2";
    lookup.address2 = @"3";
    lookup.address3 = @"4";
    lookup.address4 = @"5";
    lookup.organization = @"6";
    lookup.locality = @"7";
    lookup.administrativeArea = @"8";
    lookup.postalCode = @"9";
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(expectedUrl, [capturingSender.request getUrl]);
}

- (void)testEmptyLookupRejected {
    [self assertLookupRejected:[[SSInternationalStreetLookup alloc] init]];
}

- (void)testRejectsLookupsWithOnlyCountry {
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] init];
    lookup.country = @"0";
    [self assertLookupRejected:lookup];
}

- (void)testRejectsLookupsWithOnlyCountryAndAddress1 {
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] init];
    lookup.country = @"0";
    lookup.address1 = @"1";
    [self assertLookupRejected:lookup];
}


- (void)testRejectsLookupsWithOnlyCountryAndAddress1AndLocality {
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] init];
    lookup.country = @"0";
    lookup.address1 = @"1";
    lookup.locality = @"2";
    [self assertLookupRejected:lookup];
}


- (void)testRejectsLookupsWithOnlyCountryAndAddress1AndAdministrativeArea {
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] init];
    lookup.country = @"0";
    lookup.address1 = @"1";
    lookup.administrativeArea = @"2";
    [self assertLookupRejected:lookup];
}

- (void)assertLookupRejected:(SSInternationalStreetLookup*)lookup {
    SSMockSender *sender = [[SSMockSender alloc] init];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:nil];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    XCTAssertNotNil(error);
}

- (void)testAcceptsLookupsWithEnoughInfo {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:serializer];
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] init];
    NSError *error = nil;
    
    lookup.country = @"0";
    lookup.freeform = @"1";
    [client sendLookup:lookup error:&error];
    
    lookup.freeform = nil;
    lookup.address1 = @"1";
    lookup.postalCode = @"2";
    [client sendLookup:lookup error:&error];
    
    lookup.postalCode = nil;
    lookup.locality = @"3";
    lookup.administrativeArea = @"4";
    [client sendLookup:lookup error:&error];
    
    XCTAssertNil(error);
}

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:deserializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSInternationalStreetLookup alloc] initWithFreeform:@"1" withCountry:@"2"] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testCandidatesCorrectlyAssignedToCorrespondingLookup {
    NSArray *rawResults = [NSArray arrayWithObjects: @{@"organization": @"1"}, @{@"address1": @"2"}, nil];
    
    NSMutableArray<SSInternationalStreetCandidate*> *expectedCandidates = [NSMutableArray<SSInternationalStreetCandidate*> arrayWithObjects:
                            [[SSInternationalStreetCandidate alloc] initWithDictionary:[rawResults objectAtIndex:0]],
                            [[SSInternationalStreetCandidate alloc] initWithDictionary:[rawResults objectAtIndex:1]], nil];
    SSInternationalStreetLookup *lookup = [[SSInternationalStreetLookup alloc] initWithFreeform:@"1" withCountry:@"2"];
    
    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:rawResults];
    SSInternationalStreetClient *client = [[SSInternationalStreetClient alloc] initWithSender:sender withSerializer:deserializer];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqual([[expectedCandidates objectAtIndex:0] organization], [[lookup getResultAtIndex:0] organization]);
    XCTAssertEqual([[expectedCandidates objectAtIndex:1] address1], [[lookup getResultAtIndex:1] address1]);
}

@end
