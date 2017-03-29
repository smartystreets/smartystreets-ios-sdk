#import "SSInternationalStreetAnalysis.h"

@implementation SSInternationalStreetAnalysis

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _verificationStatus = dictionary[@"verification_status"];
        _addressPrecision = dictionary[@"address_precision"];
        _maxAddressPrecision = dictionary[@"max_address_precision"];
    }
    return self;
}

@end
