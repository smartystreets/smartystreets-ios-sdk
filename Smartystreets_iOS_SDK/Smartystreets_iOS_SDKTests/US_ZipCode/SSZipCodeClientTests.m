#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockSender.h"
#import "SSZipCodeClient.h"
#import "SSZipCodeLookup.h"

@interface SSZipCodeClientTests : XCTestCase

@end

@implementation SSZipCodeClientTests

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
    SSZipCodeClient *client = [[SSZipCodeClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSZipCodeLookup alloc] initWithZipcode:@"1"] error:&error];
    
    XCTAssertEqualObjects(@"http://localhost/?zipcode=1", sender.request.getUrl);
}

- (void)testSendingSingleFullyPopulatedLookup {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSZipCodeClient *client = [[SSZipCodeClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    SSZipCodeLookup *lookup = [[SSZipCodeLookup alloc] init];
    lookup.city = @"1";
    lookup.state = @"2";
    lookup.zipcode = @"3";
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(@"http://localhost/?city=1&state=2&zipcode=3", sender.request.getUrl);
}

//Batch Lookup

- (void)testEmptyBatchNotSent {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSZipCodeClient *client = [[SSZipCodeClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:nil];
    NSError *error = nil;
    
    [client sendBatch:[[SSZipCodeBatch alloc] init] error:&error];
    
    XCTAssertNil(sender.request);
}

- (void)testSuccessfullySendsBatchOfLookups {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *expectedPayload = [NSMutableData dataWithData:data];
    
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:expectedPayload];
    SSZipCodeClient *client = [[SSZipCodeClient alloc] initWithUrlPrefix:@"http://localhost/" withSender:sender withSerializer:serializer];
    
    NSError *error = nil;
    SSZipCodeBatch *batch = [[SSZipCodeBatch alloc] init];
    [batch add:[[SSZipCodeLookup alloc] init] error:&error];
    [batch add:[[SSZipCodeLookup alloc] init] error:&error];
    
    [client sendBatch:batch error:&error];
    
    XCTAssertEqual(expectedPayload, sender.request.payload);
}

//Response Handling

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *data = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithData:data];
    
    SSResponse *response = [[SSResponse alloc] initWithStatusCode:0 payload:mutableData];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSZipCodeClient *client = [[SSZipCodeClient alloc] initWithUrlPrefix:@"/" withSender:sender withSerializer:deserializer];
    
    NSError *error = nil;
    [client sendLookup:[[SSZipCodeLookup alloc] init] error:&error];
    
    XCTAssertEqual(response.payload, deserializer.payload);
}

- (void)testCandidatesCorrectlyAssignedToCorrespondingLookup {
    
}

@end
