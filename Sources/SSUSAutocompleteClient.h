#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSAutocompleteLookup.h"

@interface SSUSAutocompleteClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSAutocompleteLookup*)lookup error:(NSError**)error;

@end
