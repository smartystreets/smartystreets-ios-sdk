#import "SSAlternateCounties.h"

@implementation SSAlternateCounties

- (instancetype)initWithData:(NSDictionary*)data {
    if (self = [super init]) {
        _countyFips = [data objectForKey:@"county_fips"];
        _countyName = [data objectForKey:@"county_name"];
        _stateAbbreviation = [data objectForKey:@"state_abbreviation"];
        _state = [data objectForKey:@"state"];
    }
    return self;
}

@end
