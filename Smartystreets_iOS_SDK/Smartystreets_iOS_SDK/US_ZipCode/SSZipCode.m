#import "SSZipCode.h"

@implementation SSZipCode

- (instancetype)initWithData:(NSDictionary*)data {
    if (self = [super init]) {
        _zipCode = [data objectForKey:@"zipcode"];
        _zipCodeType = [data objectForKey:@"zipCodeType"];
        _defaultCity = [data objectForKey:@"default_city"];
        _countyFips = [data objectForKey:@"county_fips"];
        _countyName = [data objectForKey:@"county_name"];
        _latitude = [[data objectForKey:@"latitude"] doubleValue];
        _longitude = [[data objectForKey:@"longitude"] doubleValue];
        _precision = [data objectForKey:@"precision"];
    }
    return self;
}

@end
