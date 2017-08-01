#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockStatusCodeSender.h"
#import "SSMockSender.h"
#import "SSMockCrashingSender.h"
#import "SSURLPrefixSender.h"
#import "SSUSAutocompleteClient.h"
#import "SSUSAutocompleteLookup.h"
#import "SSUSAutocompleteResult.h"
#import "SSUSAutocompleteSuggestion.h"

@interface SSUSAutocompleteClientTests : XCTestCase

@end

@implementation SSUSAutocompleteClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// Single Lookup

- (void)testSendingSinglePrefixOnlyLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithResult:[[SSUSAutocompleteResult alloc] init]];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSUSAutocompleteLookup alloc] initWithPrefix:@"1"] error:&error];
    
    XCTAssertEqualObjects(@"1", capturingSender.request.parameters[@"prefix"]);
    XCTAssertEqualObjects(@"city", capturingSender.request.parameters[@"geolocate_precision"]);
    XCTAssertEqualObjects(@"true", capturingSender.request.parameters[@"geolocate"]);
    XCTAssertNil(capturingSender.request.parameters[@"suggestions"]);
    XCTAssertNil(capturingSender.request.parameters[@"prefer_ratio"]);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithResult:[[SSUSAutocompleteResult alloc] init]];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] init];
    lookup.prefix = @"1";
    [lookup setMaxSuggestions:2 error:&error];
    [lookup addCityFilter:@"3"];
    [lookup addStateFilter:@"4"];
    [lookup addPrefer:@"5"];
    [lookup setPreferRatio:0.6];
    [lookup setGeolocateType:[[SSGeolocateType alloc] initWithName:kSSGeolocateTypeState]];
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(@"1", capturingSender.request.parameters[@"prefix"]);
    XCTAssertEqualObjects(@"2", capturingSender.request.parameters[@"suggestions"]);
    XCTAssertEqualObjects(@"3", capturingSender.request.parameters[@"city_filter"]);
    XCTAssertEqualObjects(@"true", capturingSender.request.parameters[@"geolocate"]);
    XCTAssertEqualObjects(@"state", capturingSender.request.parameters[@"geolocate_precision"]);
    XCTAssertEqualObjects(@"4", capturingSender.request.parameters[@"state_filter"]);
    XCTAssertEqualObjects(@"5", capturingSender.request.parameters[@"prefer"]);
    XCTAssertEqualObjects(@"0.600000", capturingSender.request.parameters[@"prefer_ratio"]);
}

- (void)testSendingLookupWithGeolocateTypeSetToNone {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithResult:[[SSUSAutocompleteResult alloc] init]];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] init];
    lookup.prefix = @"1";
    [lookup setGeolocateType:[[SSGeolocateType alloc] initWithName:kSSGeolocateTypeNone]];
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(@"false", capturingSender.request.parameters[@"geolocate"]);
}

// Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSUSAutocompleteLookup alloc] initWithPrefix:@"1"] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testResultCorrectlyAssignedToCorrespondingLookup {
    NSArray *rawSuggestions = [NSArray arrayWithObjects: @{@"text": @"1"}, @{@"text": @"2"}, nil];
    NSDictionary *rawResult = @{@"suggestions": rawSuggestions};
    SSUSAutocompleteResult *expectedResult = [[SSUSAutocompleteResult alloc] initWithDictionary: rawResult];
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] initWithPrefix:@"1"];

    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *mockSender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:mockSender];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:rawResult];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:deserializer];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqual([[expectedResult.suggestions objectAtIndex:0] text], [[lookup.result objectAtIndex:0] text]);
    XCTAssertEqual([[expectedResult.suggestions objectAtIndex:1] text], [[lookup.result objectAtIndex:1] text]);
}

@end
