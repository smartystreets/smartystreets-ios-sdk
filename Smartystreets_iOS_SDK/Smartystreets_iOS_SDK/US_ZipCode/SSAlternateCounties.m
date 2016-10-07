#import "SSAlternateCounties.h"

@implementation SSAlternateCounties

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _countyFips = dictionary[@"county_fips"];
        _countyName = dictionary[@"county_name"];
        _stateAbbreviation = dictionary[@"state_abbreviation"];
        _state = dictionary[@"state"];
    }
    return self;
}

@end
