#import "SSBatch.h"

int const kSSMaxBatchSize = 100;

@implementation SSBatch

- (instancetype)init {
    if (self = [super init]) {
        _namedLookups = [[NSMutableDictionary alloc] init];
        _allLookups = [[NSMutableArray<SSLookup> alloc] init];
    }
    return self;
}

- (BOOL)add:(id<SSLookup>)newAddress error:(NSError**)error {
    if (self.allLookups.count >= kSSMaxBatchSize) {
        NSString *description = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSMaxBatchSize];
        NSDictionary *details = @{NSLocalizedDescriptionKey: description};
        *error = [NSError errorWithDomain:SSErrorDomain code:BatchFullError userInfo:details];
        return NO;
    }
    
    [self.allLookups addObject:newAddress];
    
    NSString *key = newAddress.inputId;
    if (key == nil)
        return YES;
    
    [self.namedLookups setObject:newAddress forKey:key];
    
    return YES;
}

- (void)removeAllObjects {
    [self.allLookups removeAllObjects];
    [self.namedLookups removeAllObjects];
}

- (int)count {
    return (int)[self.allLookups count];
}

- (id<SSLookup>)getLookupById:(NSString*)inputId {
    return [self.namedLookups objectForKey:inputId];
}

- (id<SSLookup>)getLookupAtIndex:(int)inputIndex {
    return [self.allLookups objectAtIndex:inputIndex];
}

@end
