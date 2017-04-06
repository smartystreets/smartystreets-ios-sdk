#import <Foundation/Foundation.h>
#import "SSResponse.h"
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSZipCodeLookup.h"
#import "SSBatch.h"

@interface SSUSZipCodeClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSZipCodeLookup*)lookup error:(NSError**)error;
- (BOOL)sendBatch:(SSBatch*)batch error:(NSError**)error;

@end
