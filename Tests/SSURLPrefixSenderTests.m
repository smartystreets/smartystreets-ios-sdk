#import <XCTest/XCTest.h>
#import "SSSmartyRequest.h"
#import "SSSmartyResponse.h"
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
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    [request setUrlPrefix:@"original"];
    NSString *override = @"override?";
    SSMockSender *inner = [[SSMockSender alloc] initWithSSSmartyResponse:[[SSSmartyResponse alloc] initWithStatusCode:123 payload:nil]];
    SSURLPrefixSender *sender = [[SSURLPrefixSender alloc] initWithUrlPrefix:override inner:inner];
    NSError *error = nil;
    
    [sender sendRequest:request error:&error];
    
    XCTAssertEqualObjects(override, request.getUrl);
}

@end
