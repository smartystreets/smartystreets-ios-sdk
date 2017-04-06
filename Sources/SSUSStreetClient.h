#import <Foundation/Foundation.h>
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSStreetLookup.h"
#import "SSBatch.h"

@interface SSUSStreetClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSStreetLookup*)lookup error:(NSError**)error;
- (BOOL)sendBatch:(SSBatch*)batch error:(NSError**)error;

@end
