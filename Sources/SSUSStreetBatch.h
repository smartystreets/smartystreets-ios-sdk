#import <Foundation/Foundation.h>
#import "SSUSStreetLookup.h"
#import "SSSmartyErrors.h"

extern int const kSSStreetMaxBatchSize;

@interface SSUSStreetBatch : NSObject

@property (readonly, nonatomic) NSMutableDictionary<NSString*, SSUSStreetLookup*> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSUSStreetLookup*> *allLookups;

- (BOOL)add:(SSUSStreetLookup*)newAddress error:(NSError**)error;
- (void)removeAllObjects;
- (int)count;
- (SSUSStreetLookup*)getLookupById:(NSString*)inputId;
- (SSUSStreetLookup*)getLookupAtIndex:(int)inputIndex;

@end
