#import "SSInternationalStreetRootLevel.h"

@implementation SSInternationalStreetRootLevel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _organization = dictionary[@"organization"];
        _address1 = dictionary[@"address1"];
        _address2 = dictionary[@"address2"];
        _address3 = dictionary[@"address3"];
        _address4 = dictionary[@"address4"];
        _address5 = dictionary[@"address5"];
        _address6 = dictionary[@"address6"];
        _address7 = dictionary[@"address7"];
        _address8 = dictionary[@"address8"];
        _address9 = dictionary[@"address9"];
        _address10 = dictionary[@"address10"];
        _address11 = dictionary[@"address11"];
        _address12 = dictionary[@"address12"];
    }
    return self;
}
@end
