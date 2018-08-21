#import <Foundation/Foundation.h>
#import "SSUSZipCodeClient.h"
#import "SSUSStreetClient.h"
#import "SSInternationalStreetClient.h"
#import "SSUSAutocompleteClient.h"
#import "SSUSExtractClient.h"
#import "SSCredentials.h"
#import "SSJsonSerializer.h"
#import "SSStaticCredentials.h"
#import "SSHttpSender.h"
#import "SSStatusCodeSender.h"
#import "SSSigningSender.h"
#import "SSRetrySender.h"
#import "SSURLPrefixSender.h"
#import "SSMyLogger.h"
#import "SSMySleeper.h"

/*!
 @class SSClientBuilder
 
 @brief The ClientBuilder class
 
 @description The ClientBuilder class helps you build a client object for one of the supported SmartyStreets APIs. You can use ClientBuilder's methods to customize settings like maximum retries or timeout duration. These methods are chainable, so you can usually get set up with one line of code.
 */
@interface SSClientBuilder : NSObject

- (instancetype)initWithSigner:(id<SSCredentials>)signer;
- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;

/*!
 @param maxRetries The maximum number of times to retry sending the request to the API. (Default is 5)
 
 @return <b>self</b> to accommodate method chaining.
 */
- (SSClientBuilder*)retryAtMost:(int)maxRetries;

/*!
 @param maxTimeout The maximum time (in milliseconds) to wait for a connection, and also to wait for <br>the response to be read. (Default is 10000)
 
 @return <b>this</b> to accommodate method chaining.
 */
- (SSClientBuilder*)withMaxTimeout:(int)maxTimeout; 

/*!
 @param sender Default is a series of nested senders. See <b>buildSender()</b>.
 
 @return <b>this</b> to accommodate method chaining.
 */
- (SSClientBuilder*)withSender:(id<SSSender>)sender;

/*!
 @brief Changes the <b>Serializer</b> from the default <b>JsonSerializer</b>.
 
 @param serializer An object that implements the <b>Serializer</b> interface.
 
 @return <b>this</b> to accommodate method chaining.
 */
- (SSClientBuilder*)withSerializer:(id<SSSerializer>)serializer;

/*!
 @brief Specifies a proxy through which the lookups will be sent.
 
 @param host The proxy host (without the scheme or port).
 
 @param port The proxy port.
 */
- (SSClientBuilder*)withProxy:(NSString*)host port:(int)port;

/*!
 @brief This may be useful when using a local installation of the SmartyStreets APIs.
 
 @param urlPrefix Defaults to the URL for the API corresponding to the <b>Client</b> object being built.
 
 @return <b>this</b> to accommodate method chaining.
 */
- (SSClientBuilder*)withUrl:(NSString*)urlPrefix;

/*!
 @brief Activates debug mode, which logs information about the HTTP requests and responses for debugging purposes.
 
 @return <b>this</b> to accommodate method chaining.
 */
- (SSClientBuilder*)withDebug;

- (SSUSZipCodeClient*)buildUsZIPCodeApiClient;
- (SSUSStreetClient*)buildUsStreetApiClient;
- (SSInternationalStreetClient*)buildInternationalStreetApiClient;
- (SSUSAutocompleteClient*)buildUsAutocompleteApiClient;
- (SSUSExtractClient*)buildUsExtractApiClient;

@end
