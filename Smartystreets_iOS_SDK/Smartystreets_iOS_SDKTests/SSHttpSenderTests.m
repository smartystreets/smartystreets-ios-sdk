#import <XCTest/XCTest.h>
#import "SSHttpSender.h"

@interface SSHttpSenderTests : XCTestCase

@end

@implementation SSHttpSenderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHttpRequestContainsCorrectHeaders {
    SSHttpSender *sender = [[SSHttpSender alloc] init]; //TODO: figure out how to do a mock nsurldatatask
//    SSHttpSender *sender = [[SSHttpSender alloc] initWithMockNSURLDataTask]; //TODO: it might look like this??
    id myMock = [OCMockObject mockForClass:[NSURLSession class]];

}

@end
