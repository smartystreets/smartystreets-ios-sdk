#import <Foundation/Foundation.h>
#import "SSUSStreetClient.h"
#import "SSCredentials.h"
#import "SSJsonSerializer.h"
#import "SSStaticCredentials.h"
#import "SSHttpSender.h"
#import "SSStatusCodeSender.h"
#import "SSSigningSender.h"
#import "SSRetrySender.h"

@interface SSUSStreetClientBuilder : NSObject

- (instancetype)initWithSigner:(id<SSCredentials>)signer;
- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;
- (SSUSStreetClientBuilder*)retryAtMost:(int)maxRetries;
- (SSUSStreetClientBuilder*)withMaxTimeout:(int)maxTimeout;
- (SSUSStreetClientBuilder*)withSender:(id<SSSender>)sender;
- (SSUSStreetClientBuilder*)withSerializer:(id<SSSerializer>)serializer;
- (SSUSStreetClientBuilder*)withUrl:(NSString*)urlPrefix;
- (SSUSStreetClient*)build;
- (id<SSSender>)buildSender;

@end
