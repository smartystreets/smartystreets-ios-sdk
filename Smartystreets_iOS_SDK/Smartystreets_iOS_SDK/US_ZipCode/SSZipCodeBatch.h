#import <Foundation/Foundation.h>
#import "SSZipCodeLookup.h"

@interface SSZipCodeBatch : NSObject

@property (readonly ,nonatomic) NSMutableDictionary<NSString*, SSZipCodeLookup*> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSZipCodeLookup*> *allLookups;

- (void)add:(SSZipCodeLookup*)lookup error:(NSError**)error;
- (void)removeAllObjects;
- (int)size;
//- (iterator<SSZipCodeLookup>)iterator;
- (SSZipCodeLookup*)getLookupById:(NSString*)inputId;
- (SSZipCodeLookup*)getLookupByIndex:(int)inputIndex;

@end

extern int const kSSMaxBatchSize;
