#import <Foundation/Foundation.h>
#import "SSLogger.h"

@interface SSMockLogger : NSObject <SSLogger>

@property (readonly, nonatomic) NSMutableArray<NSString*> *log;

@end
