#import "SSUSExtractResult.h"

@implementation SSUSExtractResult

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _metadata = [[SSUSExtractMetadata alloc] initWithDictionary:dictionary[@"meta"]];
        _addresses = [self convertToAddressObjects:dictionary];
    }
    return self;
}

- (NSArray<SSUSExtractAddress*>*)convertToAddressObjects:(NSDictionary*)dictionary {
    NSArray *addresses = [self getAddressesFromDictionary:dictionary];
    NSMutableArray<SSUSExtractAddress*> *addressObjects = [NSMutableArray<SSUSExtractAddress*> new];
    
    for (NSDictionary *a in addresses)
         [addressObjects addObject:[[SSUSExtractAddress alloc] initWithDictionary:a]];
    
    return addressObjects;
}

- (NSArray*)getAddressesFromDictionary:(NSDictionary*)dictionary {
    NSArray *addresses = dictionary[@"addresses"];
    if (addresses != nil)
        return addresses;
    else
        return [NSMutableArray<SSUSExtractAddress*> new];
}

- (SSUSExtractAddress*)getAddressAtIndex:(int)index {
    return [self.addresses objectAtIndex:index];
}

@end
