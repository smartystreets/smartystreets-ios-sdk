#import <Foundation/Foundation.h>
#import "SSZipCodeLookup.h"
#import "SSSmartyErrors.h"

extern int const kSSZipCodeMaxBatchSize;

@interface SSZipCodeBatch : NSObject

@property (readonly ,nonatomic) NSMutableDictionary<NSString*, SSZipCodeLookup*> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSZipCodeLookup*> *allLookups;

- (BOOL)add:(SSZipCodeLookup*)lookup error:(NSError**)error;
- (void)removeAllObjects;
- (int)count;
- (SSZipCodeLookup*)getLookupById:(NSString*)inputId;
- (SSZipCodeLookup*)getLookupAtIndex:(int)inputIndex;

@end
