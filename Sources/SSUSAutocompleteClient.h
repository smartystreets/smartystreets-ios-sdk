#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSAutocompleteLookup.h"

/*!
 @class SSUSAutocompleteClient
 
 @brief The US Autocomplete Client class
 
 @description This client sends lookups to the SmartyStreets US Autocomplete API, <br> and attaches the results to the appropriate Lookup objects.
 */
@interface SSUSAutocompleteClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSAutocompleteLookup*)lookup error:(NSError**)error;

@end
