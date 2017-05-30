#import <Foundation/Foundation.h>
#import "SSSmartyLogger.h"

@interface SSMockLogger : NSObject <SSSmartyLogger>

@property (readonly, nonatomic) NSMutableArray<NSString*> *log;

@end
