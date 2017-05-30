#import "SSStaticCredentials.h"

@implementation SSStaticCredentials

- (instancetype)initWithAuthId:(NSString *)authId authToken:(NSString *)authToken {
    if (self = [super init]) {
        _authId = authId;
        _authToken = authToken;
    }
    return self;
}

- (void)sign:(SSSmartyRequest *)request {
    [request setValue:self.authId forHTTPParameterField:@"auth-id"];
    [request setValue:self.authToken forHTTPParameterField:@"auth-token"];
}

@end
