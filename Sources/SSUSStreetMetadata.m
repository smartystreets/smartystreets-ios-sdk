#import "SSUSStreetMetadata.h"

@implementation SSUSStreetMetadata

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _recordType = dictionary[@"record_type"];
        _zipType = dictionary[@"zip_type"];
        _countyFips = dictionary[@"county_fips"];
        _countyName = dictionary[@"county_name"];
        _carrierRoute = dictionary[@"carrier_route"];
        _congressionalDistrict = dictionary[@"congressional_district"];
        _buildingDefaultIndicator = dictionary[@"building_default_indicator"];
        _rdi = dictionary[@"rdi"];
        _elotSequence = dictionary[@"elot_sequence"];
        _elotSort = dictionary[@"elot_sort"];
        _latitude = [dictionary[@"latitude"] doubleValue];
        _longitude = [dictionary[@"longitude"] doubleValue];
        _precision = dictionary[@"precision"];
        _timeZone = dictionary[@"time_zone"];
        _utcOffset = [dictionary[@"utc_offset"] doubleValue];
        
        if ([dictionary[@"dst"] boolValue])
            _obeysDst = YES;

        if ([dictionary[@"ews_match"] boolValue])
            _isEwsMatch = YES;

    }
    return self;
}

@end
