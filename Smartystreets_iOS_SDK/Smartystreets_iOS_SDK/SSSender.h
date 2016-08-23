#import <Foundation/Foundation.h>
#import "SSResponse.h"
#import "SSRequest.h"
#import "SmartyErrors.h"

@protocol SSSender;

@interface SSSender : NSObject

@property (nonatomic, weak) id<SSSender> delegate;

@end

@protocol SSSender <NSObject>

- (SSResponse*)sendRequest:(SSRequest*)request withError:(NSError**)error;

@end