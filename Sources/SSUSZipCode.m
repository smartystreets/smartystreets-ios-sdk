#import "SSUSZipCode.h"

@implementation SSUSZipCode

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _zipCode = dictionary[@"zipcode"];
        _zipCodeType = dictionary[@"zipcode_type"];
        _defaultCity = dictionary[@"default_city"];
        _countyFips = dictionary[@"county_fips"];
        _countyName = dictionary[@"county_name"];
        _stateAbbreviation = dictionary[@"state_abbreviation"];
        _state = dictionary[@"state"];
        _latitude = [dictionary[@"latitude"] doubleValue];
        _longitude = [dictionary[@"longitude"] doubleValue];
        _precision = dictionary[@"precision"];
        _alternateCounties = dictionary[@"alternate_counties"];
        
        if ([self.alternateCounties isEqual:[NSNull null]])
            _alternateCounties = [NSMutableArray<SSUSAlternateCounties*> new];
        
        _alternateCounties = [self convertToAlternateCountyObjects];
    }
    return self;
}

- (NSMutableArray<SSUSAlternateCounties*>*)convertToAlternateCountyObjects {
    NSMutableArray<SSUSAlternateCounties*> *altCountyObjects = [NSMutableArray<SSUSAlternateCounties*> new];
    
    for (NSDictionary *county in self.alternateCounties)
        [altCountyObjects addObject:[[SSUSAlternateCounties alloc] initWithDictionary:county]];
    
    return altCountyObjects;
}

- (SSUSAlternateCounties*)getAlternateCountiesAtIndex:(int)index {
    return [self.alternateCounties objectAtIndex:index];
}

@end
