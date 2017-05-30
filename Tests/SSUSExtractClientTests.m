#import <XCTest/XCTest.h>
#import "SSRequestCapturingSender.h"
#import "SSMockSerializer.h"
#import "SSMockDeserializer.h"
#import "SSMockSender.h"
#import "SSUSExtractClient.h"
#import "SSUSExtractLookup.h"
#import "SSURLPrefixSender.h"

@interface SSUSExtractClientTests : XCTestCase

@end

@implementation SSUSExtractClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSendingBodyOnlyLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSUSExtractClient *client = [[SSUSExtractClient alloc] initWithSender:sender withSerializer:serializer];
    NSString *helloWorld = @"Hello, World!";
    NSData *expectedPayload = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    [client sendLookup:[[SSUSExtractLookup alloc] initWithText:helloWorld] error:&error];
    
    NSMutableDictionary *parameters = capturingSender.request.parameters;
    XCTAssertEqualObjects(@"false", parameters[@"aggressive"]);
    XCTAssertEqualObjects(@"true", parameters[@"addr_line_breaks"]);
    XCTAssertEqualObjects(@"0", parameters[@"addr_per_line"]);
    XCTAssertEqualObjects(expectedPayload, capturingSender.request.payload);
}

- (void)testSendingFullyPopulatedLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSUSExtractClient *client = [[SSUSExtractClient alloc] initWithSender:sender withSerializer:serializer];
    SSUSExtractLookup *lookup = [[SSUSExtractLookup alloc] initWithText:@"1"];
    [lookup specifyHtmlInput:true];
    [lookup setAggressive:true];
    lookup.addressesHaveLineBreaks = false;
    lookup.addressesPerLine = 2;
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    NSMutableDictionary *parameters = capturingSender.request.parameters;
    XCTAssertEqualObjects(@"true", parameters[@"html"]);
    XCTAssertEqualObjects(@"true", parameters[@"aggressive"]);
    XCTAssertEqualObjects(@"false", parameters[@"addr_line_breaks"]);
    XCTAssertEqualObjects(@"2", parameters[@"addr_per_line"]);
}

- (void)testRejectNullLookup {
    SSRequestCapturingSender *capturingSender = [[SSRequestCapturingSender alloc] init];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:@"http://localhost/" inner:capturingSender];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] init];
    SSUSExtractClient *client = [[SSUSExtractClient alloc] initWithSender:sender withSerializer:serializer];
    NSError *error = nil;
    [client sendLookup:nil error:&error];
    
    XCTAssertNotNil(error);
}

- (void)testDeserializeCalledWithResponseBody {
    NSString *helloWorld = @"Hello, World!";
    NSData *expectedPayload = [helloWorld dataUsingEncoding:NSUTF8StringEncoding];
    SSSmartyResponse *response = [[SSSmartyResponse alloc] initWithStatusCode:0 payload:expectedPayload];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:response];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:nil];
    SSUSExtractClient *client = [[SSUSExtractClient alloc] initWithSender:sender withSerializer:deserializer];
    NSError *error = nil;
    
    [client sendLookup:[[SSUSExtractLookup alloc] initWithText:helloWorld] error:&error];
    
    XCTAssertEqualObjects(response.payload, deserializer.payload);
}

- (void)testResultCorrectlyAssignedToCorrespondingLookup {
    NSDictionary *rawResult = @{@"meta": @{},
                                @"addresses": [NSArray arrayWithObjects: @{@"text": @"1"}, nil]
                                };
    
    SSUSExtractResult *expectedResult = [[SSUSExtractResult alloc] initWithDictionary:rawResult];
    SSUSExtractLookup *lookup = [[SSUSExtractLookup alloc] initWithText:@"Hello, World!"];
    
    NSString *emptyString = @"[]";
    NSData *payload = [emptyString dataUsingEncoding:NSUTF8StringEncoding];
    SSMockSender *sender = [[SSMockSender alloc] initWithSSSmartyResponse:[[SSSmartyResponse alloc] initWithStatusCode:0 payload:payload]];
    SSMockDeserializer *deserializer = [[SSMockDeserializer alloc] initWithDeserializedObject:rawResult];
    SSUSExtractClient *client = [[SSUSExtractClient alloc] initWithSender:sender withSerializer:deserializer];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertNotNil(lookup.result.metadata);
    XCTAssertEqualObjects([[expectedResult.addresses objectAtIndex:0] text], [[lookup.result.addresses objectAtIndex:0] text]);
}

- (void)testContentTypeSetCorrectly {
    SSRequestCapturingSender *sender = [[SSRequestCapturingSender alloc] init];
    SSMockSerializer *serializer = [[SSMockSerializer alloc] initWithBytes:nil];
    SSUSExtractClient *client = [[SSUSExtractClient alloc] initWithSender:sender withSerializer:serializer];
    SSUSExtractLookup *lookup = [[SSUSExtractLookup alloc] initWithText:@"Hello, World!"];
    NSError *error = nil;
    
    [client sendLookup:lookup error:&error];
    
    XCTAssertEqualObjects(@"text/plain", sender.request.contentType);
}

@end
