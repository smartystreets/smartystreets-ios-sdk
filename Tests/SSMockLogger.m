#import "SSMockLogger.h"

@implementation SSMockLogger

- (instancetype)init {
    if (self = [super init]) {
        _log = [NSMutableArray<NSString*> new];
    }
    return self;
}

- (void)log:(NSString*)message {
    [self.log addObject:message];
}

@end
