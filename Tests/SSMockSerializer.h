#import <Foundation/Foundation.h>
#import "SSSerializer.h"

@interface SSMockSerializer : NSObject <SSSerializer>

- (instancetype)initWithBytes:(NSData*)bytes;
- (instancetype)initWithResult:(NSObject*)result;

@end
