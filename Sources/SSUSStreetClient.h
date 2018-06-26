#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSStreetLookup.h"
#import "SSBatch.h"

/*!
 @class SSUSStreetClient
 
 @brief The US Street Client class
 
 @description This client sends lookups to the SmartyStreets US Street API, and attaches the results to the appropriate Lookup objects.
 */
@interface SSUSStreetClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSStreetLookup*)lookup error:(NSError**)error;

/*!
 Sends a batch of up to 100 Lookup objects.
 @param batch must contain between 1 and 100 Lookup objects
 */
- (BOOL)sendBatch:(SSBatch*)batch error:(NSError**)error;

@end
