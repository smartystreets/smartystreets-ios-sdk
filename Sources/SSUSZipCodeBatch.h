#import <Foundation/Foundation.h>
#import "SSUSZipCodeLookup.h"
#import "SSSmartyErrors.h"

extern int const kSSUSZipCodeMaxBatchSize;

@interface SSUSZipCodeBatch : NSObject

@property (readonly ,nonatomic) NSMutableDictionary<NSString*, SSUSZipCodeLookup*> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSUSZipCodeLookup*> *allLookups;

- (BOOL)add:(SSUSZipCodeLookup*)lookup error:(NSError**)error;
- (void)removeAllObjects;
- (int)count;
- (SSUSZipCodeLookup*)getLookupById:(NSString*)inputId;
- (SSUSZipCodeLookup*)getLookupAtIndex:(int)inputIndex;

@end
