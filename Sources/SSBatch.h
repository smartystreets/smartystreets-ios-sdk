#import <Foundation/Foundation.h>
#import "SSLookup.h"
#import "SSSmartyErrors.h"

extern int const kSSMaxBatchSize;

/*!
 @class SSBatch
 
 @brief The Batch class
 
 @description This class contains a collection of lookups to be sent to SmartyStreets APIs all at once. This is more efficient than sending them one at a time.
 */
@interface SSBatch : NSObject

@property (readonly, nonatomic) NSMutableDictionary<NSString*, id<SSLookup>> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSLookup> *allLookups;

/*! @brief Adds a lookup to the Batch as long as there are not already 100 lookups in the batch.*/
- (BOOL)add:(id<SSLookup>)newAddress error:(NSError**)error;

/*! 
 @description Removes the lookups stored in the batch so it can be used again. This helps avoid the overhead of building a new Batch object for each group of lookups.
 */
- (void)removeAllObjects;

/*! @return the number of lookups currently in this batch */
- (int)count;
- (id<SSLookup>)getLookupById:(NSString*)inputId;
- (id<SSLookup>)getLookupAtIndex:(int)inputIndex;

@end
