#import <Foundation/Foundation.h>
#import "SSUSZipCodeClient.h"
#import "SSCredentials.h"
#import "SSJsonSerializer.h"
#import "SSStaticCredentials.h"
#import "SSHttpSender.h"
#import "SSStatusCodeSender.h"
#import "SSSigningSender.h"
#import "SSRetrySender.h"

@interface SSUSZipCodeClientBuilder : NSObject

- (instancetype)initWithSigner:(id<SSCredentials>)signer;
- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;
- (SSUSZipCodeClientBuilder*)retryAtMost:(int)maxRetries;
- (SSUSZipCodeClientBuilder*)withMaxTimeout:(int)maxTimeout;
- (SSUSZipCodeClientBuilder*)withSender:(id<SSSender>)sender;
- (SSUSZipCodeClientBuilder*)withSerializer:(id<SSSerializer>)serializer;
- (SSUSZipCodeClientBuilder*)withUrl:(NSString*)urlPrefix;
- (SSUSZipCodeClient*)build;
- (id<SSSender>)buildSender;

@end
