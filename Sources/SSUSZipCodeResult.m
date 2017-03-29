#import "SSUSZipCodeResult.h"

@implementation SSUSZipCodeResult

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _status = dictionary[@"status"];
        _reason = dictionary[@"reason"];
        _inputIndex = (int)[dictionary[@"input_index"] integerValue];
        _cities = dictionary[@"city_states"];
        _zipCodes = dictionary[@"zipcodes"];
        
        if (self.cities == nil)
            _cities = [NSMutableArray<SSCity*> new];

        if (self.zipCodes == nil)
            _zipCodes = [NSMutableArray<SSUSZipCode*> new];
            
        _cities = [self convertToCityObjects];
        _zipCodes = [self convertToZipCodeObjects];
    }
    return self;
}

- (NSMutableArray<SSCity*>*)convertToCityObjects {
    NSMutableArray<SSCity*> *cityObjects = [NSMutableArray<SSCity*> new];
    
    for (NSDictionary *city in self.cities) {
        [cityObjects addObject:[[SSCity alloc] initWithDictionary:city]];
    }
    
    return cityObjects;
}

- (NSMutableArray<SSUSZipCode*>*)convertToZipCodeObjects {
    NSMutableArray<SSUSZipCode*> *zipCodeObjects = [NSMutableArray<SSUSZipCode*> new];
    
    for (NSDictionary *zipCode in self.zipCodes) {
        [zipCodeObjects addObject:[[SSUSZipCode alloc] initWithDictionary:zipCode]];
    }
    
    return zipCodeObjects;
}

- (bool)isValid {
    return (self.status == nil && self.reason == nil);
}

- (SSCity*)getCityAtIndex:(int)index {
    return [self.cities objectAtIndex:index];
}

- (SSUSZipCode*)getZipCodeAtIndex:(int)index {
    return [self.zipCodes objectAtIndex:index];
}

@end
