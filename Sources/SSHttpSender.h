#import <Foundation/Foundation.h>
#import "SSSender.h"

@interface SSHttpSender : NSObject <SSSender>

- (instancetype)initWithMaxTimeout:(int)maxTimeout andProxy:(NSDictionary*)proxy andDebug:(bool)debug;

@end
