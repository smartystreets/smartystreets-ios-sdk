#import <XCTest/XCTest.h>
#import "SSStatusCodeSender.h"
#import "SSMockStatusCodeSender.h"

@interface SSStatusCodeSenderTests : XCTestCase

@end

@implementation SSStatusCodeSenderTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test200Response {
    SSMockStatusCodeSender *mockStatusCodeSender = [[SSMockStatusCodeSender alloc] initWithStatusCode:200];
    SSStatusCodeSender *sender = [[SSStatusCodeSender alloc] initWithInner:mockStatusCodeSender];
    NSError *error = nil;
    
    SSSmartyResponse *response = [sender sendRequest:[[SSSmartyRequest alloc] init] error:&error];
    
    XCTAssertEqual(200, response.statusCode);
}

- (void)test400ResponseThrowsBadRequestError {
    [self assertSendWithStatusCode:400];
}

- (void)test401ResponseThrowsBadCredentialsError {
    [self assertSendWithStatusCode:401];
}

- (void)test402ResponsePThrowsPaymentRequiredError {
    [self assertSendWithStatusCode:402];
}

- (void)test413ResponseThrowsRequestEntityTooLargeError {
    [self assertSendWithStatusCode:413];
}

- (void)test422ResponseThrowsUnprocessableEntityError {
    [self assertSendWithStatusCode:422];
}

- (void)test429ResponseThrowsTooManyRequestsError {
    [self assertSendWithStatusCode:429];
}

- (void)test500ResponseThrowsInternalServerError {
    [self assertSendWithStatusCode:500];
}

- (void)test503ResponseThrowsServiceUnavailableError {
    [self assertSendWithStatusCode:503];
}

- (void)test504ResponseThrowsGatewayTimeoutException {
    [self assertSendWithStatusCode:504];
}

- (void)assertSendWithStatusCode:(int)statusCode {
    SSMockStatusCodeSender *mockStatusCodeSender = [[SSMockStatusCodeSender alloc] initWithStatusCode:statusCode];
    SSStatusCodeSender *sender = [[SSStatusCodeSender alloc] initWithInner:mockStatusCodeSender];
    NSError *error = nil;
    
    [sender sendRequest:[[SSSmartyRequest alloc] init] error:&error];
    XCTAssertEqual(statusCode, [error code]);
}

@end
