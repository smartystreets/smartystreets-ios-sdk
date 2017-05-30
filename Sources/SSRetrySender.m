#import "SSRetrySender.h"

int const kSSMaxBackoffDuration = 10;

@interface SSRetrySender()

@property (readonly, nonatomic) int maxRetries;
@property (readonly, nonatomic) id<SSSender> inner;
@property (readonly, nonatomic) id<SSSmartyLogger> logger;
@property (readonly, nonatomic) id<SSSleeper> sleeper;

@end

@implementation SSRetrySender

- (instancetype)initWithMaxRetries:(int)maxRetries withSleeper:(id<SSSleeper>)sleeper withLogger:(id<SSSmartyLogger>)logger inner:(id<SSSender>)inner {
    if (self = [super init]) {
        _maxRetries = maxRetries;
        _sleeper = sleeper;
        _logger = logger;
        _inner = inner;
    }
    return self;
}

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest*)request error:(NSError **)error {
    for (int i = 0; i <= self.maxRetries; i++) {
        SSSmartyResponse *response = [self trySendingRequest:request attempts:i error:error];
        if (response != nil)
            return response;
    }
    return nil;
}

- (SSSmartyResponse*)trySendingRequest:(SSSmartyRequest*)request attempts:(int)attempt error:(NSError **)error {
    SSSmartyResponse *response;
    if (self.inner && [self.inner respondsToSelector:@selector(sendRequest:error:)]) {
        response = [self.inner sendRequest:request error:error];
    }
    
    if (response == nil) {
        [self backoff:attempt error:error];
        return nil;
    }
    
    return response;
}

- (void)backoff:(int)attempt error:(NSError **)error {
    int backoffDuration = MIN(attempt, kSSMaxBackoffDuration);
    NSMutableString *message = [NSMutableString new];
    [message appendFormat:@"There was an error processing the request. Retrying in %d seconds...", backoffDuration];
    
    [self.logger log:message];
    [self.sleeper sleep:backoffDuration];
}

@end
