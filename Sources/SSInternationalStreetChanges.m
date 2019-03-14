#import "SSInternationalStreetChanges.h"

@implementation SSInternationalStreetChanges

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        self.organization = dictionary[@"organization"];
        self.address1 = dictionary[@"address1"];
        self.address2 = dictionary[@"address2"];
        self.address3 = dictionary[@"address3"];
        self.address4 = dictionary[@"address4"];
        self.address5 = dictionary[@"address5"];
        self.address6 = dictionary[@"address6"];
        self.address7 = dictionary[@"address7"];
        self.address8 = dictionary[@"address8"];
        self.address9 = dictionary[@"address9"];
        self.address10 = dictionary[@"address10"];
        self.address11 = dictionary[@"address11"];
        self.address12 = dictionary[@"address12"];
        NSDictionary *components = dictionary[@"components"];
        
        if (components != nil)
            _components = [[SSInternationalStreetComponents alloc] initWithDictionary:components];
        
    }
    return self;
}
@end
