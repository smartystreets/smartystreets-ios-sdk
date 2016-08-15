#import <Foundation/Foundation.h>
#import "SSResponse.h"
#import "SSRequest.h"

@protocol SSSender;

@interface SSSender : NSObject

@property (nonatomic, weak) id<SSSender> delegate;

@end

@protocol SSSender <NSObject>

- (SSResponse*)send:(SSRequest*)request;

@end