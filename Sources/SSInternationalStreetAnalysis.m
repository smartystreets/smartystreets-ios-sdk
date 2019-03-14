#import "SSInternationalStreetAnalysis.h"

@implementation SSInternationalStreetAnalysis

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _verificationStatus = dictionary[@"verification_status"];
        _addressPrecision = dictionary[@"address_precision"];
        _maxAddressPrecision = dictionary[@"max_address_precision"];
        NSDictionary *changes = dictionary[@"changes"];
        
        if (changes != nil)
            _changes = [[SSInternationalStreetChanges alloc] initWithDictionary:changes];
    }
    return self;
}

@end
