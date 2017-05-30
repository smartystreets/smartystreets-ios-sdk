#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSmartyResponse.h"
#import "SSCredentials.h"
#import "SSSender.h"

@interface SSSigningSender : NSObject <SSSender>

- (instancetype)initWithSigner:(id<SSCredentials>)signer inner:(id<SSSender>)inner;

@end
