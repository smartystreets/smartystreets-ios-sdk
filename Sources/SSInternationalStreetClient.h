#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSInternationalStreetLookup.h"

/*!
 @class SSInternationalStreetClient
 
 @brief The International Street Client class
 
 @description This client sends lookups to the SmartyStreets International Street API, <br> and attaches the results to the appropriate Lookup objects.
 */
@interface SSInternationalStreetClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSInternationalStreetLookup*)lookup error:(NSError**)error;

@end
