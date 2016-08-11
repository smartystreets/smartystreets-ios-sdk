#import <Foundation/Foundation.h>

@protocol SSSender <NSObject>

- (SSResponse)send:(SSRequest)request;

@end