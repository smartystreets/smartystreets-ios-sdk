#import <Foundation/Foundation.h>
#import "SSResponse.h"
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSZipCodeLookup.h"
#import "SSBatch.h"

/*!
 @class SSUSZipCodeClient
 
 @brief The US ZIPCode Client class
 
 @description This client sends lookups to the SmartyStreets US ZIP Code API, and attaches the results to the appropriate Lookup objects.
 */
@interface SSUSZipCodeClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSZipCodeLookup*)lookup error:(NSError**)error;
- (BOOL)sendBatch:(SSBatch*)batch error:(NSError**)error;

@end
