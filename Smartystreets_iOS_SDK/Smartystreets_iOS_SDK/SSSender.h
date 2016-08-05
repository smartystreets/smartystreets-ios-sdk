#import <Foundation/Foundation.h>

@protocol SSSender <NSObject>

- (Response)send:(Request)request;

@end