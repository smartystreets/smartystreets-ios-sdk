#import <Foundation/Foundation.h>
#import "SSStreetClient.h"
#import "SSCredentials.h"
#import "SSJsonSerializer.h"
#import "SSStaticCredentials.h"
#import "SSHttpSender.h"
#import "SSStatusCodeSender.h"
#import "SSSigningSender.h"
#import "SSRetrySender.h"

@interface SSStreetClientBuilder : NSObject

- (instancetype)initWithSigner:(id<SSCredentials>)signer;
- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;
- (SSStreetClientBuilder*)retryAtMost:(int)maxRetries;
- (SSStreetClientBuilder*)withMaxTimeout:(int)maxTimeout;
- (SSStreetClientBuilder*)withSender:(id<SSSender>)sender;
- (SSStreetClientBuilder*)withSerializer:(id<SSSerializer>)serializer;
- (SSStreetClientBuilder*)withUrl:(NSString*)urlPrefix;
- (SSStreetClient*)build;
- (id<SSSender>)buildSender;

@end
