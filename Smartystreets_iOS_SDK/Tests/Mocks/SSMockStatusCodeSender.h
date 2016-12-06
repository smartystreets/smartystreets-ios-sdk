#import <Foundation/Foundation.h>
#import "SSSender.h"

@interface SSMockStatusCodeSender : NSObject <SSSender>

-(instancetype)initWithStatusCode:(int)statusCode;

@end
