#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSExtractLookup.h"

/*!
 @class SSUSExtractClient
 
 @brief The US Extract Client class
 
 @description This client sends lookups to the SmartyStreets US Extract API, and attaches the results to the Lookup objects.
 */
@interface SSUSExtractClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSExtractLookup*)lookup error:(NSError**)error;

@end
