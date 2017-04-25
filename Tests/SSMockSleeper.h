#import <Foundation/Foundation.h>
#import "SSSleeper.h"

@interface SSMockSleeper : NSObject <SSSleeper>

@property (readonly, nonatomic) NSMutableArray *sleepDurations;

@end
