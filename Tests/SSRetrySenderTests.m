#import <XCTest/XCTest.h>
#import "SSRetrySender.h"
#import "SSMockCrashingSender.h"
#import "SSMockLogger.h"
#import "SSMockSleeper.h"

@interface SSRetrySenderTests : XCTestCase

@property (nonatomic) SSMockCrashingSender *mockCrashingSender;
@property (nonatomic) SSMockLogger *mockLogger;
@property (nonatomic) SSMockSleeper *mockSleeper;

@end

@implementation SSRetrySenderTests

- (void)setUp {
    [super setUp];
    self.mockCrashingSender = [[SSMockCrashingSender alloc] init];
    self.mockLogger = [[SSMockLogger alloc] init];
    self.mockSleeper = [[SSMockSleeper alloc] init];
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

- (void)testBackoffDoesNotExceedMax {
    NSArray *expectedDurations = [[NSArray alloc] initWithObjects:@(0), @(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10), @(10), @(10), @(10), nil];
    NSError *error = nil;
    
    [self sendRequest:@"RetryFifteenTimes" error:&error];
    
    XCTAssertEqual(15, self.mockCrashingSender.sendCount);
    XCTAssertEqualObjects(expectedDurations, self.mockSleeper.sleepDurations);
}

- (void)sendRequest:(NSString*)requestBehavior error:(NSError**)error {
    SSSmartyRequest *request = [[SSSmartyRequest alloc] init];
    request.urlPrefix = requestBehavior;
    SSRetrySender *retrySender = [[SSRetrySender alloc] initWithMaxRetries:15 withSleeper:self.mockSleeper withLogger:self.mockLogger inner:self.mockCrashingSender];
    
    [retrySender sendRequest:request error:error];
}

@end
