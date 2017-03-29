#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockSender.h"
#import "SSUSStreetClient.h"
#import "SSUSStreetLookup.h"
#import "SSUSZipCodeResult.h"

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
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSUSStreetLookup alloc] initWithFreeformAddress:@"freeform"] error:&error];
    
    XCTAssertEqualObjects(@"http://localhost/?street=freeform", sender.request.getUrl);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithUrlPrefix:@"http://localhost" withSender:sender withSerializer:serializer];
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
    
    //TODO: change the test to not be dependent on the URL. Indivually test the urlPrefix, the slash, and the parameters
    XCTAssertEqualObjects(@"http://localhost?street=1&city=5&lastline=8&addressee=0&zipcode=7&candidates=9&urbanization=4&street2=3&secondary=2&state=6", sender.request.getUrl);
}

// Batch Lookup

- (void)testEmptyBatchNotSent {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:nil];
    NSError *error = nil;
    
    [client sendBatch:[[SSUSStreetBatch alloc] init] error:&error];
    
    XCTAssertNil(sender.request);
}

- (void)testSuccessfullySendsBatchOfAddressLookups {
    NSString *helloWorld = @"Hello, World!";
    NSData *expectedPayload = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:expectedPayload];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    
    NSError *error = nil;
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqualObjects(expectedPayload, sender.request.payload);
}

// Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSUSStreetLookup alloc] init] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testCandidatesCorrectlyAssignedToCorrespondingLookup {
    NSMutableArray<SSUSStreetCandidate*> *expectedCandidates = [[NSMutableArray<SSUSStreetCandidate*> alloc] init];
    [expectedCandidates insertObject:[[SSUSStreetCandidate alloc] initWithInputIndex:0] atIndex:0];
    [expectedCandidates insertObject:[[SSUSStreetCandidate alloc] initWithInputIndex:1] atIndex:1];
    [expectedCandidates insertObject:[[SSUSStreetCandidate alloc] initWithInputIndex:1] atIndex:2];
    SSUSStreetBatch *batch = [[SSUSStreetBatch alloc] init];
    NSError *error = nil;
    
    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    [batch add:[[SSUSStreetLookup alloc] init] error:&error];
    
    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:expectedCandidates];
    SSUSStreetClient *client = [[SSUSStreetClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:deserializer];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqual([expectedCandidates objectAtIndex:0], [[batch getLookupAtIndex:0] getResultAtIndex:0]);
    XCTAssertEqual([expectedCandidates objectAtIndex:1], [[batch getLookupAtIndex:1] getResultAtIndex:0]);
    XCTAssertEqual([expectedCandidates objectAtIndex:2], [[batch getLookupAtIndex:1] getResultAtIndex:1]);
}

@end
