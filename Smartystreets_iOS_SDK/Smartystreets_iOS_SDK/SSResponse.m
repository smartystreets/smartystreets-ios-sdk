#import "SSResponse.h"

@implementation SSResponse

- (instancetype)initWithStatusCode:(NSInteger)statusCode payload:(NSMutableData*)payload {
    if (self = [super init]) {
        _statusCode = statusCode;
        _payload = payload;
    }
    return self;
}

@end
