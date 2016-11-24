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

- (BOOL)add:(SSZipCodeLookup*)lookup error:(NSError**)error {
    if ([self.allLookups count] >= kSSZipCodeMaxBatchSize) {
        NSString *description = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSZipCodeMaxBatchSize];
        NSDictionary *details = @{NSLocalizedDescriptionKey: description};
        *error = [NSError errorWithDomain:SSErrorDomain code:BatchFullError userInfo:details];
        return NO;
    }
    
    [self.allLookups addObject:lookup];
    
    NSString *key = lookup.inputId;
    if (key == nil)
        return YES;
    
    [self.namedLookups setObject:lookup forKey:key];
    
    return YES;
}

- (void)removeAllObjects {
    [self.namedLookups removeAllObjects];
    [self.allLookups removeAllObjects];
}

- (int)count {
    return (int)[self.allLookups count];
}

- (SSZipCodeLookup*)getLookupById:(NSString*)inputId {
    return [self.namedLookups objectForKey:inputId];
}

- (SSZipCodeLookup*)getLookupAtIndex:(int)inputIndex {
    return [self.allLookups objectAtIndex:inputIndex];
}

@end
