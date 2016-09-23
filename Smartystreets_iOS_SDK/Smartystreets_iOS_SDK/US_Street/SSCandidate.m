#import "SSCandidate.h"

@implementation SSCandidate

- (instancetype)initWithInputIndex:(int)inputIndex {
    if (self = [super init])
        _inputIndex = inputIndex;
    return self;
}

@end
