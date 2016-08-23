#import "SSSigningSender.h"

@interface SSSigningSender()

@property (readonly, nonatomic) id<SSCredentials> signer;
@property (readonly, nonatomic) id<SSSender> inner;

@end

@implementation SSSigningSender

- (instancetype)initWithSigner:(id<SSCredentials>)signer inner:(id<SSSender>)inner {
    if (self = [super init]) {
        _signer = signer;
        _inner = inner;
    }
    return self;
}

- (SSResponse*)sendRequest:(SSRequest *)request withError:(NSError**)error {
    if (self.inner && [self.signer respondsToSelector:@selector(sign:)]) {
        [self.signer sign:request];
    }
    
    SSResponse *response;
    if (self.inner && [self.inner respondsToSelector:@selector(sendRequest:withError:)]) {
        response = [self.inner sendRequest:request withError:error];
    }
    return response;
}

@end
