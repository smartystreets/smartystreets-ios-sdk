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
    SSMockSender *mockSender = [[SSMockSender alloc] initWithSSResponse:nil];
    SSSigningSender *sender = [[SSSigningSender alloc] initWithSigner:signer inner:mockSender];
    NSError *error = nil;
    
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/"];
    [sender sendRequest:request withError:&error];
    
    NSString *expectedUrl = @"http://localhost/?auth-id=authId&auth-token=secret";
    XCTAssertEqualObjects(expectedUrl, [mockSender.request getUrl]);
}

- (void)testResponseReturnedCorrectly {
    SSStaticCredentials *signer = [[SSStaticCredentials alloc] initWithAuthId:@"authId" authToken:@"secret"];
    SSResponse *expectedResponse = [[SSResponse alloc] initWithStatusCode:200 payload:nil];
    SSMockSender *mockSender = [[SSMockSender alloc] initWithSSResponse:expectedResponse];
    SSSigningSender *sender = [[SSSigningSender alloc] initWithSigner:signer inner:mockSender];
    NSError *error = nil;
    
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:@"http://localhost/"];
    SSResponse *actualResponse = [sender sendRequest:request withError:&error];
    
    XCTAssertEqualObjects(expectedResponse, actualResponse);
}

@end
