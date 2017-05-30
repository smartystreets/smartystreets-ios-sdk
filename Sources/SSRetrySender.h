#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSmartyErrors.h"
#import "SSSmartyLogger.h"
#import "SSSleeper.h"

extern int const kSSMaxBackoffDuration;

@interface SSRetrySender : NSObject <SSSender>

- (instancetype)initWithMaxRetries:(int)maxRetries withSleeper:(id<SSSleeper>)sleeper withLogger:(id<SSSmartyLogger>)logger inner:(id<SSSender>)inner;

@end
