#import "SSUSZipCodeBatch.h"

int const kSSUSZipCodeMaxBatchSize = 100;

@implementation SSUSZipCodeBatch

- (instancetype)init {
    if (self = [super init]) {
        _namedLookups = [[NSMutableDictionary<NSString*, SSUSZipCodeLookup*> alloc] init];
        _allLookups = [[NSMutableArray<SSUSZipCodeLookup*> alloc] init];
    }
    return self;
}

- (BOOL)add:(SSUSZipCodeLookup*)lookup error:(NSError**)error {
    if ([self.allLookups count] >= kSSUSZipCodeMaxBatchSize) {
        NSString *description = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSUSZipCodeMaxBatchSize];
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

- (SSUSZipCodeLookup*)getLookupById:(NSString*)inputId {
    return [self.namedLookups objectForKey:inputId];
}

- (SSUSZipCodeLookup*)getLookupAtIndex:(int)inputIndex {
    return [self.allLookups objectAtIndex:inputIndex];
}

@end
