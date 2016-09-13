#import <Foundation/Foundation.h>
#import "SSSender.h"

@interface SSRequestCapturingSender : NSObject <SSSender>

@property (readonly, nonatomic) SSRequest *request;

@end
