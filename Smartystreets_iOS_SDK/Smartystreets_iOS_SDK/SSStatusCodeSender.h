#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SmartyErrors.h"

@interface SSStatusCodeSender : NSObject <SSSender>

- (instancetype)initWithInner:(id<SSSender>)inner;

@end
