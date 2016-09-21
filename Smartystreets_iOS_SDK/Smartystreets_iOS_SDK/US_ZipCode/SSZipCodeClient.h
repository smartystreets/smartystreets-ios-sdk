#import <Foundation/Foundation.h>
#import "SSResponse.h"
#import "SSSender.h"
#import "SSSerializer.h"
#import "SSZipCodeBatch.h"

@interface SSZipCodeClient : NSObject

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix withSender:(id<SSSender>)sender withSerializer:(id<SSSerializer>)serializer;
- (void)sendLookup:(SSZipCodeLookup*)lookup error:(NSError**)error;
- (void)sendBatch:(SSZipCodeBatch*)batch error:(NSError**)error;

@end
