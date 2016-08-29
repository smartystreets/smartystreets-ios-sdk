#import <XCTest/XCTest.h>
#import "SSRetrySender.h"
#import "SSMockCrashingSender.h"

@interface SSRetrySenderTests : XCTestCase

@property (nonatomic) SSMockCrashingSender *mockCrashingSender;

@end

@implementation SSRetrySenderTests

- (void)setUp {
    [super setUp];
    self.mockCrashingSender = [[SSMockCrashingSender alloc] init];
}

- (void)tearDown {

    [super tearDown];
}

- (void)testSuccessDoesNotRetry {
    NSError *error = nil;
    [self sendRequest:@"DoNotRetry" error:&error];
    
    XCTAssertEqual(1, self.mockCrashingSender.sendCount);
}

- (void)testRetryUntilSuccess {
    NSError *error = nil;
    [self sendRequest:@"RetryThreeTimes" error:&error];
    
    XCTAssertEqual(4, self.mockCrashingSender.sendCount);
}

- (void)testRetryUntilMaxAttempts {
    NSError *error = nil;
    [self sendRequest:@"RetryMaxTimes" error:&error];
    
    XCTAssertNotNil(error);
}

- (void)sendRequest:(NSString*)requestBehavior error:(NSError**)error {
    SSRequest *request = [[SSRequest alloc] initWithUrlPrefix:requestBehavior];
    SSRetrySender *retrySender = [[SSRetrySender alloc] initWithMaxRetries:5 inner:self.mockCrashingSender];
    
    [retrySender sendRequest:request withError:error];
}

@end
