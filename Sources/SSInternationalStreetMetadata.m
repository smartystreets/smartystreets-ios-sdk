#import "SSInternationalStreetMetadata.h"

@implementation SSInternationalStreetMetadata

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _latitude = [dictionary[@"latitude"] doubleValue];
        _longitude = [dictionary[@"longitude"] doubleValue];
        _geocodePrecision = dictionary[@"geocode_precision"];
        _maxGeocodePrecision = dictionary[@"max_geocode_precision"];
    }
    return self;
}

@end
