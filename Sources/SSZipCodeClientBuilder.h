#import <Foundation/Foundation.h>
#import "SSZipCodeClient.h"
#import "SSCredentials.h"
#import "SSJsonSerializer.h"
#import "SSStaticCredentials.h"
#import "SSHttpSender.h"
#import "SSStatusCodeSender.h"
#import "SSSigningSender.h"
#import "SSRetrySender.h"

@interface SSZipCodeClientBuilder : NSObject

- (instancetype)initWithSigner:(id<SSCredentials>)signer;
- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;
- (SSZipCodeClientBuilder*)retryAtMost:(int)maxRetries;
- (SSZipCodeClientBuilder*)withMaxTimeout:(int)maxTimeout;
- (SSZipCodeClientBuilder*)withSender:(id<SSSender>)sender;
- (SSZipCodeClientBuilder*)withSerializer:(id<SSSerializer>)serializer;
- (SSZipCodeClientBuilder*)withUrl:(NSString*)urlPrefix;
- (SSZipCodeClient*)build;
- (id<SSSender>)buildSender;

@end
