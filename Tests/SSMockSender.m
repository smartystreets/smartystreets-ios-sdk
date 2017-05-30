#import "SSMockSender.h"

@interface SSMockSender()

@property (readonly, nonatomic) SSSmartyResponse *response;

@end

@implementation SSMockSender

- (instancetype)initWithSSSmartyResponse:(SSSmartyResponse*)response {
    if (self = [super init]) {
        _response = response;
    }
    return self;
}

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest*)request error:(NSError**)error {
    _request = request;
    return self.response;
}

@end
