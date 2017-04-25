#import "SSMockSleeper.h"

@implementation SSMockSleeper

- (instancetype)init {
    if (self = [super init]) {
        _sleepDurations = [NSMutableArray new];
    }
    return self;
}

- (void)sleep:(int)seconds {
    [self.sleepDurations addObject:[NSNumber numberWithInt:seconds]];
}

- (NSArray*)getSleepDurations {
    return self.sleepDurations;
}

@end
