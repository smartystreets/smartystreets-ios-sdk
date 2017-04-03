#import <Foundation/Foundation.h>
#import "SSSender.h"

@interface SSURLPrefixSender : NSObject <SSSender>

@property (readonly, nonatomic) NSString *urlPrefix;

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix inner:(id<SSSender>)inner;

@end
