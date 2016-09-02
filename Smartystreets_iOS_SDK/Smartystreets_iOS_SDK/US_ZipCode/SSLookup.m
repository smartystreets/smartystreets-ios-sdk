#import "SSLookup.h"

@implementation SSLookup

- (instancetype)init {
    if (self = [super init])
        _result = [[SSResult alloc] init];
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
