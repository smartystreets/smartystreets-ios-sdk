#import "SSResult.h"

@implementation SSResult

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
            _zipCodes = [NSMutableArray<SSZipCode*> new];
            
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

- (NSMutableArray<SSZipCode*>*)convertToZipCodeObjects {
    NSMutableArray<SSZipCode*> *zipCodeObjects = [NSMutableArray<SSZipCode*> new];
    
    for (NSDictionary *zipCode in self.zipCodes) {
        [zipCodeObjects addObject:[[SSZipCode alloc] initWithDictionary:zipCode]];
    }
    
    return zipCodeObjects;
}

- (NSDictionary*)toDictionary {
    return [@{
              @"status" : self.status,
              @"reason" : self.reason,
              @"input_index" : [@(self.inputIndex) stringValue],
              @"city_states" : self.cities, //TODO: do I need to add a toDictionary in the SSCity and SSZipCode as well?
              @"zipcodes" : self.zipCodes //TODO: do I need to add a toDictionary in the SSCity and SSZipCode as well?
              } mutableCopy];
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
