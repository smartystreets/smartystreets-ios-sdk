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

- (SSResponse*)sendRequest:(SSRequest*)request error:(NSError**)error {
    _request = request;
    return self.response;
}

@end
