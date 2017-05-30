#import "SSSmartyResponse.h"

@implementation SSSmartyResponse

- (instancetype)initWithStatusCode:(NSInteger)statusCode payload:(NSData*)payload {
    if (self = [super init]) {
        _statusCode = statusCode;
        _payload = payload;
    }
    return self;
}

@end
