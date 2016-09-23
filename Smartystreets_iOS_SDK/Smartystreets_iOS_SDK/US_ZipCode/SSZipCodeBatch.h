#import <Foundation/Foundation.h>
#import "SSZipCodeLookup.h"
#import "SmartyErrors.h"

extern int const kSSZipCodeMaxBatchSize;

@interface SSZipCodeBatch : NSObject

@property (readonly ,nonatomic) NSMutableDictionary<NSString*, SSZipCodeLookup*> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSZipCodeLookup*> *allLookups;

- (void)add:(SSZipCodeLookup*)lookup error:(NSError**)error;
- (void)removeAllObjects;
- (int)count;
//- (iterator<SSZipCodeLookup>)iterator;
- (SSZipCodeLookup*)getLookupById:(NSString*)inputId;
- (SSZipCodeLookup*)getLookupAtIndex:(int)inputIndex;

@end
