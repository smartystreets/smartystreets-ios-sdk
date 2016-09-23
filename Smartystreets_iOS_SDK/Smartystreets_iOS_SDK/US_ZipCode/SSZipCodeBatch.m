#import "SSZipCodeBatch.h"

int const kSSZipCodeMaxBatchSize = 100;

@implementation SSZipCodeBatch

- (instancetype)init {
    if (self = [super init]) {
        _namedLookups = [[NSMutableDictionary<NSString*, SSZipCodeLookup*> alloc] init];
        _allLookups = [[NSMutableArray<SSZipCodeLookup*> alloc] init];
    }
    return self;
}

- (void)add:(SSZipCodeLookup*)lookup error:(NSError**)error {
    if ([self.allLookups count] >= kSSZipCodeMaxBatchSize) {
        NSString *description = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSZipCodeMaxBatchSize];
        NSDictionary *details = @{NSLocalizedDescriptionKey: description};
        *error = [NSError errorWithDomain:SSErrorDomain code:BatchFullError userInfo:details];
        return;
    }
    
    [self.allLookups addObject:lookup];
    
    NSString *key = lookup.inputId;
    if (key == nil)
        return;
    
    [self.namedLookups setObject:lookup forKey:key];
}

- (void)removeAllObjects {
    [self.namedLookups removeAllObjects];
    [self.allLookups removeAllObjects];
}

- (int)count {
    return (int)[self.allLookups count];
}

//- (iterator<SSLookup>)iterator; //TODO: figure out how to implement this

- (SSZipCodeLookup*)getLookupById:(NSString*)inputId {
    return [self.namedLookups objectForKey:inputId];
}

- (SSZipCodeLookup*)getLookupAtIndex:(int)inputIndex {
    return [self.allLookups objectAtIndex:inputIndex];
}

@end
