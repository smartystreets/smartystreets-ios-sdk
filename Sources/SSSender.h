#import <Foundation/Foundation.h>
#import "SSSmartyResponse.h"
#import "SSSmartyRequest.h"
#import "SSSmartyErrors.h"

@protocol SSSender;

@interface SSSender : NSObject

@property (nonatomic, weak) id<SSSender> delegate;

@end

@protocol SSSender <NSObject>

- (SSSmartyResponse*)sendRequest:(SSSmartyRequest*)request error:(NSError**)error;

@end
