#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SmartyErrors.h"

@interface SSRetrySender : NSObject <SSSender>

- (instancetype)initWithMaxRetries:(int)maxRetries inner:(id<SSSender>)inner;
- (SSResponse*)trySendingRequest:(SSRequest*)request attempts:(int)attempt error:(NSError **)error;

@end
