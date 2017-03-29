#import "SSUSStreetComponents.h"

@implementation SSUSStreetComponents

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _urbanization = dictionary[@"urbanization"];
        _primaryNumber = dictionary[@"primary_number"];
        _streetName = dictionary[@"street_name"];
        _streetPredirection = dictionary[@"street_predirection"];
        _streetPostdirection = dictionary[@"street_postdirection"];
        _streetSuffix = dictionary[@"street_suffix"];
        _secondaryNumber = dictionary[@"secondary_number"];
        _secondaryDesignator = dictionary[@"secondary_designator"];
        _extraSecondaryNumber = dictionary[@"extra_secondary_number"];
        _extraSecondaryDesignator = dictionary[@"extra_secondary_designator"];
        _pmbDesignator = dictionary[@"pmb_designator"];
        _pmbNumber = dictionary[@"pmb_number"];
        _cityName = dictionary[@"city_name"];
        _defaultCityName = dictionary[@"default_city_name"];
        _state = dictionary[@"state_abbreviation"];
        _zipCode = dictionary[@"zipcode"];
        _plus4Code = dictionary[@"plus4_code"];
        _deliveryPoint = dictionary[@"delivery_point"];
        _deliveryPointCheckDigit = dictionary[@"delivery_point_check_digit"];
    }
    return self;
}

@end
