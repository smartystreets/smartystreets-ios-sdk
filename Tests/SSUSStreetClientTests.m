#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockSender.h"
#import "SSUSStreetClient.h"
#import "SSUSStreetLookup.h"
#import "SSURLPrefixSender.h"

@interface SSUSStreetClientTests : XCTestCase

@end

@implementation SSUSStreetClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// Single Lookup

- (void)testSendingSingleFreeformLookup {
    NSString *expectedUrl = @"http://localhost/?street=freeform";
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSUSStreetLookup alloc] initWithFreeformAddress:@"freeform"] error:&error];
    
    NSString *actualUrl = sender.request.getUrl;
    
    XCTAssertEqualObjects(expectedUrl, actualUrl);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithSender:sender withSerializer:serializer];
    SSUSStreetLookup *lookup = [[SSUSStreetLookup alloc] init];
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
    
    XCTAssertEqualObjects(@"http://localhost/?street=1&city=5&lastline=8&addressee=0&zipcode=7&candidates=9&urbanization=4&street2=3&secondary=2&state=6", capturingSender.request.getUrl);
}

// Batch Lookup

- (void)testEmptyBatchNotSent {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithSender:sender withSerializer:nil];
    NSError *error = nil;
    
    [client sendBatch:[[SSBatch alloc] init] error:&error];
    
    XCTAssertNil(sender.request);
}

- (void)testSuccessfullySendsBatchOfAddressLookups {
    NSString *helloWorld = @"Hello, World!";
    NSData *expectedPayload = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:expectedPayload];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithSender:sender withSerializer:serializer];
    
    NSError *error = nil;
    SSBatch *batch = [[SSBatch alloc] init];
    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqualObjects(expectedPayload, sender.request.payload);
}

// Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSUSStreetLookup alloc] init] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testCandidatesCorrectlyAssignedToCorrespondingLookup {
    NSArray *rawResults = [NSArray arrayWithObjects:
                                 @{@"input_index": [NSNumber numberWithInt:0], @"addressee": @"addressee1"},
                                 @{@"input_index": [NSNumber numberWithInt:1], @"addressee": @"addressee2"},
                                 @{@"input_index": [NSNumber numberWithInt:1], @"addressee": @"addressee3"}, nil];
    
    NSMutableArray<SSUSStreetCandidate*> *expectedCandidates = [NSMutableArray<SSUSStreetCandidate*> arrayWithObjects:
                       [[SSUSStreetCandidate alloc] initWithDictionary:[rawResults objectAtIndex:0]],
                       [[SSUSStreetCandidate alloc] initWithDictionary:[rawResults objectAtIndex:1]],
                       [[SSUSStreetCandidate alloc] initWithDictionary:[rawResults objectAtIndex:2]], nil];
    
    SSBatch *batch = [[SSBatch alloc] init];
    NSError *error = nil;

    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    
    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:rawResults];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithSender:sender withSerializer:deserializer];
    
    [client sendBatch:batch error:&error];
    
    SSUSStreetLookup *lookup1 = [batch getLookupAtIndex:0];
    SSUSStreetLookup *lookup2 = [batch getLookupAtIndex:1];
    
    XCTAssertEqual([[expectedCandidates objectAtIndex:0] addressee], [[lookup1 getResultAtIndex:0] addressee]);
    XCTAssertEqual([[expectedCandidates objectAtIndex:1] addressee], [[lookup2 getResultAtIndex:0] addressee]);
    XCTAssertEqual([[expectedCandidates objectAtIndex:2] addressee], [[lookup2 getResultAtIndex:1] addressee]);
}

@end
