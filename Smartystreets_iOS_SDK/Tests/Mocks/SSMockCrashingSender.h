#import <Foundation/Foundation.h>
#import "SSSender.h"

@interface SSMockCrashingSender : NSObject <SSSender>

@property (readonly, nonatomic) int sendCount;

@end
