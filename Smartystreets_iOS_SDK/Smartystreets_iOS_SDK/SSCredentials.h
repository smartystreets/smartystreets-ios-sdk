#import <Foundation/Foundation.h>
#import "SSRequest.h"

@protocol SSCredentials <NSObject>

- (void)sign:(SSRequest*)request;

@end