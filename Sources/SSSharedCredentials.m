#import "SSSharedCredentials.h"

@implementation SSSharedCredentials

- (instancetype)initWithId:(NSString*)id hostname:(NSString*)hostname {
    if (self = [super init]) {
        _id = id;
        _hostname = hostname;
    }
    return self;
}

- (void)sign:(SSSmartyRequest*)request {
    [request setValue:self.id forHTTPParameterField:@"auth-id"];
    
    NSString *fullHostname = [@"https://" stringByAppendingString:self.hostname];
    [request setValue:fullHostname forHTTPHeaderField:@"Referer"];
}

@end
