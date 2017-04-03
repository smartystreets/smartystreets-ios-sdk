#import <XCTest/XCTest.h>
#import "SSRequest.h"
#import "SSResponse.h"
#import "SSMockSender.h"
#import "SSURLPrefixSender.h"

@interface SSURLPrefixSenderTests : XCTestCase

@end

@implementation SSURLPrefixSenderTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testProvidedURLOverridesRequestURL {
    SSRequest *request = [[SSRequest alloc] init];
    [request setUrlPrefix:@"original"];
    NSString *override = @"override?";
    SSMockSender *inner = [[SSMockSender alloc] initWithSSResponse:[[SSResponse alloc] initWithStatusCode:123 payload:nil]];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:override inner:inner];
    NSError *error = nil;
    
    [sender sendRequest:request error:&error];
    
    XCTAssertEqualObjects(override, request.getUrl);
}

@end
