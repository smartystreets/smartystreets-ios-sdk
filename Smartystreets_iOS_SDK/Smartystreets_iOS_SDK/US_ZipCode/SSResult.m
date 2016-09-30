#import "SSResult.h"

@implementation SSResult

- (instancetype)initWithData:(NSDictionary*)data {
    if (self = [super init]) {
        _status = [data objectForKey:@"status"];
        _reason = [data objectForKey:@"reason"];
        _inputIndex = (int)[[data objectForKey:@"input_index"] integerValue];
        _cities = [data objectForKey:@"city_states"];
        _zipCodes = [data objectForKey:@"zipcodes"];
        
        if (self.cities == nil)
            _cities = [NSMutableArray<SSCity*> new];

        if (self.zipCodes == nil)
            _zipCodes = [NSMutableArray<SSZipCode*> new];
            
        _cities = [self convertToCityObjects];
        _zipCodes = [self convertToZipCodeObjects];
    }
    return self;
}

- (NSMutableArray<SSCity*>*)convertToCityObjects {
    NSMutableArray<SSCity*> *cityObjects = [NSMutableArray<SSCity*> new];
    
    for (NSDictionary *city in self.cities) {
        [cityObjects addObject:[[SSCity alloc] initWithData:city]];
    }
    
    return cityObjects;
}

- (NSMutableArray<SSZipCode*>*)convertToZipCodeObjects {
    NSMutableArray<SSZipCode*> *zipCodeObjects = [NSMutableArray<SSZipCode*> new];
    
    for (NSDictionary *zipCode in self.zipCodes) {
        [zipCodeObjects addObject:[[SSZipCode alloc] initWithData:zipCode]];
    }
    
    return zipCodeObjects;
}

- (bool)isValid {
    return (self.status == nil && self.reason == nil);
}

- (SSCity*)getCityAtIndex:(int)index {
    return [self.cities objectAtIndex:index];
}

- (SSZipCode*)getZipCodeAtIndex:(int)index {
    return [self.zipCodes objectAtIndex:index];
}

@end
