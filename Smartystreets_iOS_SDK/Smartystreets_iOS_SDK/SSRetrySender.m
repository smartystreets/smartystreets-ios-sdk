#import "SSRetrySender.h"

@interface SSRetrySender()

@property (readonly, nonatomic) int maxRetries;
@property (readonly, nonatomic) id<SSSender> inner;

@end

@implementation SSRetrySender

- (instancetype)initWithMaxRetries:(int)maxRetries inner:(id<SSSender>)inner {
    if (self = [super init]) {
        _maxRetries = maxRetries;
        _inner = inner;
    }
    return self;
}

-(SSResponse*)sendRequest:(SSRequest*)request withError:(NSError **)error {
    for (int i = 0; i <= self.maxRetries; i++) {
        SSResponse *response = [self trySendingRequest:request attempts:i error:error];
        if (response != nil)
            return response;
    }
    return nil;
}

- (SSResponse*)trySendingRequest:(SSRequest*)request attempts:(int)attempt error:(NSError **)error{
    SSResponse *response;
    if (self.inner && [self.inner respondsToSelector:@selector(sendRequest:withError:)]) {
        response = [self.inner sendRequest:request withError:error];
    }
    
    return (response) ? response : nil;
}

@end
