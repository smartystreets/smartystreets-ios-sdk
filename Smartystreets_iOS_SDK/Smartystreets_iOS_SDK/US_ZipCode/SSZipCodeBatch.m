#import "SSZipCodeBatch.h"

int const kSSMaxBatchSize = 100;

@implementation SSZipCodeBatch

- (instancetype)init {
    if (self = [super init]) {
        _namedLookups = [[NSMutableDictionary<NSString*, SSZipCodeLookup*> alloc] init];
        _allLookups = [[NSMutableArray<SSZipCodeLookup*> alloc] init];
    }
    return self;
}

- (void)add:(SSZipCodeLookup*)lookup error:(NSError**)error {
    if ([self.allLookups count] >= kSSMaxBatchSize) {
        //TODO: set BatchFullError
    }
    
    NSString *key = lookup.inputId;
    
    if (key != nil)
        [self.namedLookups setObject:lookup forKey:key];
    
    [self.allLookups addObject:lookup];
}

- (void)removeAllObjects {
    [self.namedLookups removeAllObjects];
    [self.allLookups removeAllObjects];
}

- (int)size {
    return (int)[self.allLookups count];
}

//- (iterator<SSLookup>)iterator; //TODO: figure out how to implement this

- (SSZipCodeLookup*)getLookupById:(NSString*)inputId {
    return [self.namedLookups objectForKey:inputId];
}

- (SSZipCodeLookup*)getLookupByIndex:(int)inputIndex {
    return [self.allLookups objectAtIndex:inputIndex];
}

@end
