#import <Foundation/Foundation.h>
#import "SSSender.h"

@interface SSMockSender : NSObject <SSSender>

@property (readonly, nonatomic) SSRequest *request;

- (instancetype)initWithSSResponse:(SSResponse*)response;

@end
