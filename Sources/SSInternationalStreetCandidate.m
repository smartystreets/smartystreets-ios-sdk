#import "SSInternationalStreetCandidate.h"

@implementation SSInternationalStreetCandidate

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
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
        NSDictionary *components = dictionary[@"components"];
        NSDictionary *metadata = dictionary[@"metadata"];
        NSDictionary *analysis = dictionary[@"analysis"];
        
        if (components != nil)
            _components = [[SSInternationalStreetComponents alloc] initWithDictionary:components];
        
        if (metadata != nil)
            _metadata = [[SSInternationalStreetMetadata alloc] initWithDictionary:metadata];
        
        if (analysis != nil)
            _analysis = [[SSInternationalStreetAnalysis alloc] initWithDictionary:analysis];
    }
    return self;
}

@end
