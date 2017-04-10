#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSInternationalStreetLookup.h"

@interface SSInternationalStreetClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSInternationalStreetLookup*)lookup error:(NSError**)error;

@end
