#import <Foundation/Foundation.h>
#import "SSStreetLookup.h"
#import "SmartyErrors.h"

extern int const kSSStreetMaxBatchSize;

@interface SSStreetBatch : NSObject

@property (readonly, nonatomic) NSMutableDictionary<NSString*, SSStreetLookup*> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSStreetLookup*> *allLookups;
@property (nonatomic) Boolean standardizeOnly;
@property (nonatomic) Boolean includeInvalid;

- (void)add:(SSStreetLookup*)newAddress error:(NSError**)error;
- (void)reset;
- (void)removeAllObjects;
- (int)count;
//- (iterator<SSZipCodeLookup>)iterator;
- (SSStreetLookup*)getLookupById:(NSString*)inputId;
- (SSStreetLookup*)getLookupAtIndex:(int)inputIndex;

@end
