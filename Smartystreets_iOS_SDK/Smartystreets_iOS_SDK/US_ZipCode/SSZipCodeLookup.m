#import "SSZipCodeLookup.h"

@implementation SSZipCodeLookup

- (instancetype)init {
    if (self = [super init])
        _result = [[SSResult alloc] init];
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if ([self = [super self] init]) {
        _city = dictionary[@"city"];
        _state = dictionary[@"state"];
        _zipcode = dictionary[@"zipcode"];
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

- (NSDictionary*)toDictionary {
    return [@{
//              @"result" : [self.result toDictionary], //TODO: does it need this?
//              @"inputid" : self.inputId, //TODO: does it need this?
              @"city" : self.city,
              @"state" : self.state,
              @"zipcode" : self.zipcode
            } mutableCopy];
}

@end
