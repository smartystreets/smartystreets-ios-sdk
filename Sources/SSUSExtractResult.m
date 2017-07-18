#import "SSUSExtractResult.h"

@implementation SSUSExtractResult

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _metadata = [[SSUSExtractMetadata alloc] initWithDictionary:dictionary[@"meta"]];
        _addresses = dictionary[@"addresses"];
        
        if ([self.addresses isEqual:[NSNull null]])
            _addresses = [NSMutableArray<SSUSExtractAddress*> new];
        
        _addresses = [self convertToAddressObjects:dictionary];
    }
    return self;
}

- (NSArray<SSUSExtractAddress*>*)convertToAddressObjects:(NSDictionary*)dictionary {
    NSMutableArray<SSUSExtractAddress*> *addressObjects = [NSMutableArray<SSUSExtractAddress*> new];
    
    for (NSDictionary *a in self.addresses)
         [addressObjects addObject:[[SSUSExtractAddress alloc] initWithDictionary:a]];
    
    return addressObjects;
}

- (SSUSExtractAddress*)getAddressAtIndex:(int)index {
    return [self.addresses objectAtIndex:index];
}

@end
