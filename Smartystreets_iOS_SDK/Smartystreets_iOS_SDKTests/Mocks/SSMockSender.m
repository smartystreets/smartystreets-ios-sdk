#import "SSMockSender.h"

@interface SSMockSender()

@property (readonly, nonatomic) SSResponse *response;

@end

@implementation SSMockSender

- (instancetype)initWithSSResponse:(SSResponse*)response {
    if (self = [super init]) {
        _response = response;
    }
    return self;
}

- (SSResponse*)send:(SSRequest*)request {
    _request = request;
    return self.response;
}

@end
