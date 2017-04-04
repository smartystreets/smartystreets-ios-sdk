#import <Foundation/Foundation.h>
#import "SSResponse.h"
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSUSZipCodeBatch.h"

@interface SSUSZipCodeClient : NSObject

- (instancetype)initWithSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (BOOL)sendLookup:(SSUSZipCodeLookup*)lookup error:(NSError**)error;
- (BOOL)sendBatch:(SSUSZipCodeBatch*)batch error:(NSError**)error;

@end
