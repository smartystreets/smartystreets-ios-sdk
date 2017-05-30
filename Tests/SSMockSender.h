#import <Foundation/Foundation.h>
#import "SSSender.h"

@interface SSMockSender : NSObject <SSSender>

@property (readonly, nonatomic) SSSmartyRequest *request;

- (instancetype)initWithSSSmartyResponse:(SSSmartyResponse*)response;

@end
