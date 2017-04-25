#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSmartyErrors.h"
#import "SSLogger.h"
#import "SSSleeper.h"

extern int const kSSMaxBackoffDuration;

@interface SSRetrySender : NSObject <SSSender>

- (instancetype)initWithMaxRetries:(int)maxRetries withSleeper:(id<SSSleeper>)sleeper withLogger:(id<SSLogger>)logger inner:(id<SSSender>)inner;

@end
