#import <XCTest/XCTest.h>
#import "SSSigningSender.h"
#import "SSStaticCredentials.h"
#import "SSMockSender.h"

@interface SSSigningSenderTests : XCTestCase

@end

@implementation SSSigningSenderTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSigningOfRequest {
    SSStaticCredentials *signer = [[SSStaticCredentials alloc] initWithAuthId:@"authId" authToken:@"secret"];
    SSMockSender *mockSender = [[SSMockSender alloc] initWithSSSmartyResponse:nil];
    SSSigningSender *sender = [[SSSigningSender alloc] initWithSigner:signer inner:mockSender];
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    request.urlPrefix = @"http://localhost/";
    NSError *error = nil;
    
    [sender sendRequest:request error:&error];
    
    NSString *expectedUrl = @"http://localhost/?auth-id=authId&auth-token=secret";
    XCTAssertEqualObjects(expectedUrl, [mockSender.request getUrl]);
}

- (void)testResponseReturnedCorrectly {
    SSStaticCredentials *signer = [[SSStaticCredentials alloc] initWithAuthId:@"authId" authToken:@"secret"];
    SSSmartyResponse *expectedResponse = [[SSSmartyResponse alloc] initWithStatusCode:200 payload:nil];
    SSMockSender *mockSender = [[SSMockSender alloc] initWithSSSmartyResponse:expectedResponse];
    SSSigningSender *sender = [[SSSigningSender alloc] initWithSigner:signer inner:mockSender];
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    request.urlPrefix = @"http://localhost/";
    NSError *error = nil;
    
    SSSmartyResponse *actualResponse = [sender sendRequest:request error:&error];
    
    XCTAssertEqualObjects(expectedResponse, actualResponse);
}

@end
