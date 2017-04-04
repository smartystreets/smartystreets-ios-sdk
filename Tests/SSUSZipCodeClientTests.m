#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockSender.h"
#import "SSUSZipCodeClient.h"
#import "SSUSZipCodeLookup.h"

@interface SSUSZipCodeClientTests : XCTestCase

@end

@implementation SSUSZipCodeClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//Single Lookup

- (void)testSendingSingleZipOnlyLookup {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSUSZipCodeLookup alloc] initWithZipcode:@"1"] error:&error];
    
    XCTAssertEqualObjects(@"http://localhost/?zipcode=1", sender.request.getUrl);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:serializer];
    SSUSZipCodeLookup *lookup = [[SSUSZipCodeLookup alloc] init];
    lookup.city = @"1";
    lookup.state = @"2";
    lookup.zipcode = @"3";
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    //TODO: change the test to not be dependent on the URL. Indivually test the urlPrefix, the slash, and the parameters
    XCTAssertEqualObjects(@"http://localhost/?state=2&city=1&zipcode=3", sender.request.getUrl);
}

//Batch Lookup

- (void)testEmptyBatchNotSent {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:nil];
    NSError *error = nil;
    
    [client sendBatch:[[SSUSZipCodeBatch alloc] init] error:&error];
    
    XCTAssertNil(sender.request);
}

- (void)testSuccessfullySendsBatchOfLookups {
    NSString *helloWorld = @"Hello, World!";
    NSData *expectedPayload = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:expectedPayload];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:serializer];
    
    NSError *error = nil;
    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqual(expectedPayload, sender.request.payload);
}

//Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSUSZipCodeLookup alloc] init] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testCandidatesCorrectlyAssignedToCorrespondingLookup {
    NSMutableDictionary *rawResult1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithInt:0], @"input_index",
                                       @"status1", @"status", nil];
    NSMutableDictionary *rawResult2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithInt:1], @"input_index",
                                       @"status2", @"status", nil];
    NSMutableArray *rawResults = [[NSMutableArray alloc] initWithObjects:rawResult1, rawResult2, nil];
    
    NSMutableArray<SSUSZipCodeResult*> *expectedCandidates = [[NSMutableArray<SSUSZipCodeResult*> alloc] init];
    [expectedCandidates insertObject:[[SSUSZipCodeResult alloc] initWithDictionary:rawResult1] atIndex:0];
    [expectedCandidates insertObject:[[SSUSZipCodeResult alloc] initWithDictionary:rawResult2] atIndex:1];

    SSUSZipCodeBatch *batch = [[SSUSZipCodeBatch alloc] init];
    NSError *error = nil;
    
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    
    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:rawResults];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:deserializer];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqualObjects([[expectedCandidates objectAtIndex:0] status], [[[batch getLookupAtIndex:0] result] status]);
    XCTAssertEqualObjects([[expectedCandidates objectAtIndex:1] status], [[[batch getLookupAtIndex:1] result] status]);
}

@end
