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
    
    [client sendBatch:[[SSBatch alloc] init] error:&error];
    
    XCTAssertNil(sender.request);
}

- (void)testSuccessfullySendsBatchOfLookups {
    NSString *helloWorld = @"Hello, World!";
    NSData *expectedPayload = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:expectedPayload];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:serializer];
    
    NSError *error = nil;
    SSBatch *batch = [[SSBatch alloc] init];
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqual(expectedPayload, sender.request.payload);
}

//Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:data];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSUSZipCodeLookup alloc] init] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testCandidatesCorrectlyAssignedToCorrespondingLookup {
    NSArray *rawResults = [NSArray arrayWithObjects:
                           @{@"input_index": [NSNumber numberWithInt:0], @"status": @"status1"},
                           @{@"input_index": [NSNumber numberWithInt:1], @"status": @"status2"}, nil];
    
    NSMutableArray<SSUSZipCodeResult*> *expectedCandidates = [NSMutableArray<SSUSZipCodeResult*> arrayWithObjects:
                                            [[SSUSZipCodeResult alloc] initWithDictionary:[rawResults objectAtIndex:0]],
                                            [[SSUSZipCodeResult alloc] initWithDictionary:[rawResults objectAtIndex:1]], nil];

    SSBatch *batch = [[SSBatch alloc] init];
    NSError *error = nil;
    
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    [batch add:[[SSUSZipCodeLookup alloc] init] error:&error];
    
    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:payload];
    
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:rawResults];
    SSUSZipCodeClient *client = [[SSUSZipCodeClient alloc] initWithSender:sender withSerializer:deserializer];
    
    [client sendBatch:batch error:&error];
    
    SSUSZipCodeLookup *lookup1 = [batch getLookupAtIndex:0];
    SSUSZipCodeLookup *lookup2 = [batch getLookupAtIndex:1];
    
    XCTAssertEqualObjects([[expectedCandidates objectAtIndex:0] status], [[lookup1 result] status]);
    XCTAssertEqualObjects([[expectedCandidates objectAtIndex:1] status], [[lookup2 result] status]);
}

@end
