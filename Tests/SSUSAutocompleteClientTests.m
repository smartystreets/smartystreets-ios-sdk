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
    
    XCTAssertEqualObjects(@"http://localhost/?suggestions=10&geolocate_precision=city&geolocate=true&prefix=1", [capturingSender.request getUrl]);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithResult:[[SSUSAutocompleteResult alloc] init]];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    NSString *expectedUrl = @"http://localhost/?prefer=5&prefix=1&state_filter=4&geolocate=true&city_filter=3&suggestions=2&geolocate_precision=state";
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] init];
    lookup.prefix = @"1";
    [lookup setMaxSuggestions:2 error:&error];
    [lookup addCityFilter:@"3"];
    [lookup addStateFilter:@"4"];
    [lookup addPrefer:@"5"];
    [lookup setGeolocateType:[[SSGeolocateType alloc] initWithName:kSSGeolocateTypeState]];
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(expectedUrl, [capturingSender.request getUrl]);
}

// Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSUSAutocompleteLookup alloc] initWithPrefix:@"1"] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testResultCorrectlyAssignedToCorrespondingLookup {
    NSArray *rawResults = [NSArray arrayWithObjects:
                           @{@"text": @"1"}, @{@"text": @"2"}, nil];
    
    NSArray<SSUSAutocompleteSuggestion*> *suggestions =
            [NSMutableArray<SSUSAutocompleteSuggestion*> arrayWithObjects:
             [rawResults objectAtIndex:0],
             [rawResults objectAtIndex:1], nil];
    
    SSUSAutocompleteResult *expectedResult = [[SSUSAutocompleteResult alloc] initWithDictionary:
                                              @{@"suggestions": suggestions}];
    
    SSUSAutocompleteLookup *lookup = [[SSUSAutocompleteLookup alloc] initWithPrefix:@"1"];

    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *mockSender = [[SSMockSender alloc] initWithSSResponse:response];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:mockSender];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:rawResults];
    SSUSAutocompleteClient *client = [[SSUSAutocompleteClient alloc] initWithSender:sender withSerializer:deserializer];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqual(expectedResult.suggestions, lookup.result);
}


@end
