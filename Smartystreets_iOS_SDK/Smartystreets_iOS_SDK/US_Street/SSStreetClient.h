#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSStreetBatch.h"

@interface SSStreetClient : NSObject

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix withSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (void)sendLookup:(SSStreetLookup*)lookup error:(NSError**)error;
- (void)sendBatch:(SSStreetBatch*)batch error:(NSError**)error;

@end
