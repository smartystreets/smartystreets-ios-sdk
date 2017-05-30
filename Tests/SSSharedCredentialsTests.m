#import <XCTest/XCTest.h>
#import "SSSharedCredentials.h"

@interface SSSharedCredentialsTests : XCTestCase

@property (nonatomic) SSSmartyRequest *request;

@end

@implementation SSSharedCredentialsTests

- (void)setUp {
    [super setUp];

    SSSharedCredentials *mobile = [[SSSharedCredentials alloc] initWithId:@"3516378604772256" hostname:@"example.com"];
    _request = [[SSSmartyRequest alloc] init];
    self.request.urlPrefix = @"https://api.smartystreets.com/street-address?";
    
    [mobile sign:self.request];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSignedRequest {
    NSString *expectedValue = @"https://api.smartystreets.com/street-address?auth-id=3516378604772256";
    XCTAssertEqualObjects(expectedValue, [self.request getUrl]);
}

- (void)testReferringHeader {
    NSString *actualValue = [[self.request headers] objectForKey:@"Referer"];
    XCTAssertEqualObjects(@"https://example.com", actualValue);
}



@end
