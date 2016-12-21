#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSmartyErrors.h"

@interface SSStatusCodeSender : NSObject <SSSender>

- (instancetype)initWithInner:(id<SSSender>)inner;

@end
