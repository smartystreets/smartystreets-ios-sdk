#import "SSZipCode.h"

@implementation SSZipCode

- (instancetype)initWithData:(NSDictionary*)data {
    if (self = [super init]) {
        _zipCode = [data objectForKey:@"zipcode"];
        _zipCodeType = [data objectForKey:@"zipcode_type"];
        _defaultCity = [data objectForKey:@"default_city"];
        _countyFips = [data objectForKey:@"county_fips"];
        _countyName = [data objectForKey:@"county_name"];
        _stateAbbreviation = [data objectForKey:@"state_abbreviation"];
        _state = [data objectForKey:@"state"];
        _latitude = [[data objectForKey:@"latitude"] doubleValue];
        _longitude = [[data objectForKey:@"longitude"] doubleValue];
        _precision = [data objectForKey:@"precision"];
        _alternateCounties = [data objectForKey:@"alternate_counties"];
        
        if (self.alternateCounties == nil)
            _alternateCounties = [NSMutableArray<SSAlternateCounties*> new];
        
        _alternateCounties = [self convertToAlternateCountyObjects];
    }
    return self;
}

- (NSMutableArray<SSAlternateCounties*>*)convertToAlternateCountyObjects {
    NSMutableArray<SSAlternateCounties*> *altCountyObjects = [NSMutableArray<SSAlternateCounties*> new];
    
    for (NSDictionary *county in self.alternateCounties)
        [altCountyObjects addObject:[[SSAlternateCounties alloc] initWithData:county]];
    
    return altCountyObjects;
}

- (SSAlternateCounties*)getAlternateCountiesAtIndex:(int)index {
    return [self.alternateCounties objectAtIndex:index];
}

@end
