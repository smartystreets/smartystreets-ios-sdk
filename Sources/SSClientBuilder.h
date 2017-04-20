#import <Foundation/Foundation.h>
#import "SSUSZipCodeClient.h"
#import "SSUSStreetClient.h"
#import "SSInternationalStreetClient.h"
#import "SSUSAutocompleteClient.h"
#import "SSCredentials.h"
#import "SSJsonSerializer.h"
#import "SSStaticCredentials.h"
#import "SSHttpSender.h"
#import "SSStatusCodeSender.h"
#import "SSSigningSender.h"
#import "SSRetrySender.h"
#import "SSURLPrefixSender.h"

@interface SSClientBuilder : NSObject

- (instancetype)initWithSigner:(id<SSCredentials>)signer;
- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;
- (SSClientBuilder*)retryAtMost:(int)maxRetries;
- (SSClientBuilder*)withMaxTimeout:(int)maxTimeout;
- (SSClientBuilder*)withSender:(id<SSSender>)sender;
- (SSClientBuilder*)withSerializer:(id<SSSerializer>)serializer;
- (SSClientBuilder*)withUrl:(NSString*)urlPrefix;

- (SSUSZipCodeClient*)buildUsZIPCodeApiClient;
- (SSUSStreetClient*)buildUsStreetApiClient;
- (SSInternationalStreetClient*)buildInternationalStreetApiClient;
- (SSUSAutocompleteClient*)buildUsAutocompleteClient;

@end
