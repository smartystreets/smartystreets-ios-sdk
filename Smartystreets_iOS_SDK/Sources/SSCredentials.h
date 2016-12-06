#import <Foundation/Foundation.h>
#import "SSRequest.h"

@protocol SSCredentials;

@interface SSCredentials : NSObject

@property (nonatomic, weak) id<SSCredentials> delegate;

@end

@protocol SSCredentials <NSObject>

- (void)sign:(SSRequest*)request;

@end

