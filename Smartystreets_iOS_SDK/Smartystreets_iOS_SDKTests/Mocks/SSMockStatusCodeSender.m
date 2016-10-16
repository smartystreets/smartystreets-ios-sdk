#import "SSMockStatusCodeSender.h"

@interface SSMockStatusCodeSender()

@property (readonly, nonatomic) int statusCode;

@end

@implementation SSMockStatusCodeSender

-(instancetype)initWithStatusCode:(int)statusCode {
    if (self = [super init]) {
        _statusCode = statusCode;
    }
    return self;
}

- (SSResponse*)sendRequest:(SSRequest*)request error:(NSError**)error {
    if (self.statusCode == 0)
        return nil;
    
    return [[SSResponse alloc] initWithStatusCode:self.statusCode payload:nil];
}

@end
