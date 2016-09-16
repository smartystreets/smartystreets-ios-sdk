#import <Foundation/Foundation.h>
#import "SSSerializer.h"

@interface SSMockSerializer : NSObject <SSSerializer>

- (instancetype)initWithBytes:(NSMutableData*)bytes;

@end
