#import <XCTest/XCTest.h>
#import "SSStaticCredentials.h"

@interface SSStaticCredentialsTests : XCTestCase

@end

@implementation SSStaticCredentialsTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testStandardCredentials {
    [self assertSignedRequestWithAuthId:@"f83280df-s83d-f82j-d829-kd02l9tis7ek" secret:@"S9Djk63k2Ilj67vN82Km" expectedValue:@"https://api.smartystreets.com/street-address?auth-id=f83280df-s83d-f82j-d829-kd02l9tis7ek&auth-token=S9Djk63k2Ilj67vN82Km"];
}

- (void)testUrlEncoding {
    [self assertSignedRequestWithAuthId:@"as3$d8+56d9" secret:@"d8j#ds'dfe2" expectedValue:@"https://api.smartystreets.com/street-address?auth-id=as3%24d8%2B56d9&auth-token=d8j%23ds%27dfe2"];
}

- (void)assertSignedRequestWithAuthId:(NSString*)authId secret:(NSString*)secret expectedValue:(NSString*)expectedValue {
    SSStaticCredentials *credentials = [[SSStaticCredentials alloc] initWithAuthId:authId authToken:secret];
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    request.urlPrefix = @"https://api.smartystreets.com/street-address";
    
    [credentials sign:request];
    
    XCTAssertEqualObjects(expectedValue, [request getUrl]);
}

@end
