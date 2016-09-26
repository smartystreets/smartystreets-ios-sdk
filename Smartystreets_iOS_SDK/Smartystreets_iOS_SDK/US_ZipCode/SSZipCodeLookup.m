#import "SSZipCodeLookup.h"

@implementation SSZipCodeLookup

- (instancetype)init {
    if (self = [super init])
        _result = [[SSResult alloc] init];
    return self;
}

- (instancetype)initWithData:(NSDictionary*)data {
    if ([self = [super self] init]) {
        _city = [data objectForKey:@"city"];
        _state = [data objectForKey:@"state"];
        _zipcode = [data objectForKey:@"zipcode"];
    }
    return self;
}

- (instancetype)initWithZipcode:(NSString*)zipcode {
    if (self = [[super self] init])
        _zipcode = zipcode;
    return self;
}

- (instancetype)initWithCity:(NSString*)city state:(NSString*)state {
    if (self = [[super self] init]) {
        _city = city;
        _state = state;
    }
    return self;
}

- (instancetype)initWithCity:(NSString*)city state:(NSString*)state zipcode:(NSString*)zipcode {
    if (self = [[super self] init]) {
        _city = city;
        _state = state;
        _zipcode = zipcode;
    }
    return self;
}

@end
