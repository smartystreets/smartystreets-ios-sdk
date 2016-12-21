#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSmartyErrors.h"

@interface SSRetrySender : NSObject <SSSender>

- (instancetype)initWithMaxRetries:(int)maxRetries inner:(id<SSSender>)inner;

@end
