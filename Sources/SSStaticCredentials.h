#import <Foundation/Foundation.h>
#import "SSCredentials.h"

/*!
 @class SSStaticCredentials
 
 @brief The Static Credentials Class
 
 @description StaticCredentials takes a SmartyStreets Secret Key Pair, and 'signs' the request with it so the SmartyStreets API knows which SmartyStreets account and subscription is sending it. <p>Look on the <b>API Keys</b> tab of your SmartyStreets account page to find/generate your keys.</p>
 */
@interface SSStaticCredentials : NSObject <SSCredentials>

@property (nonatomic) NSString *authId;
@property (nonatomic) NSString *authToken;

- (instancetype)initWithAuthId:(NSString*)authId authToken:(NSString*)authToken;

@end
