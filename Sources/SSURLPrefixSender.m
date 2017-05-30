#import "SSURLPrefixSender.h"

@interface SSURLPrefixSender()

@property (readonly, nonatomic) id<SSSender> inner;

@end

@implementation SSURLPrefixSender

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix inner:(id<SSSender>)inner {
    if (self = [super init]) {
        _urlPrefix = urlPrefix;
        _inner = inner;
    }
    return self;
}

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest *)request error:(NSError**)error {
    request.urlPrefix = self.urlPrefix;
    return [self.inner sendRequest:request error:error];
}

@end
