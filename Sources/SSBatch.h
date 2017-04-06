#import <Foundation/Foundation.h>
#import "SSLookup.h"
#import "SSSmartyErrors.h"

extern int const kSSMaxBatchSize;

@interface SSBatch : NSObject

@property (readonly, nonatomic) NSMutableDictionary<NSString*, id<SSLookup>> *namedLookups;
@property (readonly, nonatomic) NSMutableArray<SSLookup> *allLookups;

- (BOOL)add:(id<SSLookup>)newAddress error:(NSError**)error;
- (void)removeAllObjects;
- (int)count;
- (id<SSLookup>)getLookupById:(NSString*)inputId;
- (id<SSLookup>)getLookupAtIndex:(int)inputIndex;

@end
