#import "SSMyLogger.h"

@implementation SSMyLogger

- (void)log:(NSString *)message {
    NSString * mystring = [@"\n" stringByAppendingString:message];
    
    NSLog(@"%@", mystring);
}

@end
