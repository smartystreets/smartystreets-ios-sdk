#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockSender.h"
#import "SSStreetClient.h"
#import "SSStreetLookup.h"
#import "SSResult.h"

@interface SSStreetClientTests : XCTestCase

@end

@implementation SSStreetClientTests

- (void)setUp {
    [super setUp];

}

- (void)tearDown {

    [super tearDown];
}

// Single Lookup

- (void)testSendingSingleFreeformLookup {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSStreetLookup alloc] initWithFreeformAddress:@"freeform"] error:&error];
    
    XCTAssertEqualObjects(@"http://localhost/?street=freeform", sender.request.getUrl);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:@"http://localhost" withSender:sender withSerializer:serializer];
    SSStreetLookup *lookup = [[SSStreetLookup alloc] init];
    NSError *error = nil;
    
    lookup.addressee = @"0";
    lookup.street = @"1";
    lookup.secondary = @"2";
    lookup.street2 = @"3";
    lookup.urbanization = @"4";
    lookup.city = @"5";
    lookup.state = @"6";
    lookup.zipCode = @"7";
    lookup.lastline = @"8";
    [lookup setMaxCandidates:9 error:&error];
    
    [client sendLookup:lookup error:&error];
    
    //TODO: change the test to not be dependent on the URL. Indivually test the urlPrefix, the slash, and the parameters
    XCTAssertEqualObjects(@"http://localhost?street=1&city=5&lastline=8&addressee=0&zipcode=7&candidates=9&urbanization=4&street2=3&secondary=2&state=6", sender.request.getUrl);
}

// Batch Lookup

- (void)testEmptyBatchNotSent {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:nil];
    NSError *error = nil;
    
    [client sendBatch:[[SSStreetBatch alloc] init] error:&error];
    
    XCTAssertNil(sender.request);
}

- (void)testSuccessfullySendsBatchOfAddressLookups {
    NSString *helloWorld = @"Hello, World!";
    NSData *expectedPayload = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:expectedPayload];
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    
    NSError *error = nil;
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    [batch add:[[SSStreetLookup alloc] init] error:&error];
    [batch add:[[SSStreetLookup alloc] init] error:&error];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqualObjects(expectedPayload, sender.request.payload);
}

// Request Headers

- (void)testNoHeadersAddedToRequest {
    [self assertHeadersSetCorrectlyForIncludeInvalid:NO standardizeOnly:NO];
}

- (void)testIncludeInvalidHeaderCorrectlyAddedToRequest {
    [self assertHeadersSetCorrectlyForIncludeInvalid:YES standardizeOnly:NO];
}

- (void)testStandardizeOnlyHeaderCorrectlyAddedToRequest {
    [self assertHeadersSetCorrectlyForIncludeInvalid:NO standardizeOnly:YES];
}

- (void)testIncludeInvalidHeaderCorrectlyAddedToRequestWhenBothBatchOptionsAreSet {
    [self assertHeadersSetCorrectlyForIncludeInvalid:YES standardizeOnly:YES];
}

- (void)assertHeadersSetCorrectlyForIncludeInvalid:(Boolean)includeInvalid standardizeOnly:(Boolean)standardizeOnly {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:[[NSMutableData alloc] init]];
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    NSError *error = nil;
    
    [batch add:[[SSStreetLookup alloc] init] error:&error];
    
    batch.standardizeOnly = standardizeOnly;
    batch.includeInvalid = includeInvalid;
    [client sendBatch:batch error:&error];
    
    SSRequest *request = sender.request;
    NSMutableDictionary *headers = request.headers;
    
    if (includeInvalid) {
        XCTAssertEqualObjects(@"true", [headers objectForKey:@"X-Include-Invalid"]);
        XCTAssertNil([headers objectForKey:@"X-Standard-Only"]);
    } else if (standardizeOnly) {
        XCTAssertEqualObjects(@"true", [headers objectForKey:@"X-Standardize-Only"]);
        XCTAssertNil([headers objectForKey:@"X-Include-Invalid"]);
    } else {
        XCTAssertNil([headers objectForKey:@"X-Include-Invalid"]);
        XCTAssertNil([headers objectForKey:@"X-Standardize-Only"]);
    }
}

// Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSStreetLookup alloc] init] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testCandidatesCorrectlyAssignedToCorrespondingLookup {
    NSMutableArray<SSCandidate*> *expectedCandidates = [[NSMutableArray<SSCandidate*> alloc] init];
    [expectedCandidates insertObject:[[SSCandidate alloc] initWithInputIndex:0] atIndex:0];
    [expectedCandidates insertObject:[[SSCandidate alloc] initWithInputIndex:1] atIndex:1];
    [expectedCandidates insertObject:[[SSCandidate alloc] initWithInputIndex:1] atIndex:2];
    SSStreetBatch *batch = [[SSStreetBatch alloc] init];
    NSError *error = nil;
    
    [batch add:[[SSStreetLookup alloc] init] error:&error];
    [batch add:[[SSStreetLookup alloc] init] error:&error];
    
    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:expectedCandidates];
    SSStreetClient *client = [[SSStreetClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:deserializer];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqual([expectedCandidates objectAtIndex:0], [[batch getLookupAtIndex:0] getResultAtIndex:0]);
    XCTAssertEqual([expectedCandidates objectAtIndex:1], [[batch getLookupAtIndex:1] getResultAtIndex:0]);
    XCTAssertEqual([expectedCandidates objectAtIndex:2], [[batch getLookupAtIndex:1] getResultAtIndex:1]);
}

@end
