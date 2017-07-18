#import "SSUSZipCodeResult.h"

@implementation SSUSZipCodeResult

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _status = dictionary[@"status"];
        _reason = dictionary[@"reason"];
        _inputIndex = (int)[dictionary[@"input_index"] integerValue];
        _cities = dictionary[@"city_states"];
        _zipCodes = dictionary[@"zipcodes"];
        
        if ([self.cities isEqual:[NSNull null]])
            _cities = [NSMutableArray<SSUSCity*> new];

        if ([self.zipCodes isEqual:[NSNull null]])
            _zipCodes = [NSMutableArray<SSUSZipCode*> new];
            
        _cities = [self convertToCityObjects];
        _zipCodes = [self convertToZipCodeObjects];
    }
    return self;
}

- (NSMutableArray<SSUSCity*>*)convertToCityObjects {
    NSMutableArray<SSUSCity*> *cityObjects = [NSMutableArray<SSUSCity*> new];
    
    for (NSDictionary *city in self.cities) {
        [cityObjects addObject:[[SSUSCity alloc] initWithDictionary:city]];
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

- (SSUSCity*)getCityAtIndex:(int)index {
    return [self.cities objectAtIndex:index];
}

- (SSUSZipCode*)getZipCodeAtIndex:(int)index {
    return [self.zipCodes objectAtIndex:index];
}

@end
