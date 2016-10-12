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
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
//       @"result" : [self.result toDictionary], //TODO: does it need this?
//       @"inputid" : self.inputId, //TODO: does it need this?
    dictionary = [self addValueToDictionary:self.city key:@"city" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.state key:@"state" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.zipcode key:@"zipcode" dictionary:dictionary];
    
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
//    return [@{
//              @"result" : [self.result toDictionary], //TODO: does it need this?
//              @"inputid" : self.inputId, //TODO: does it need this?
//              @"city" : self.city,
//              @"state" : self.state,
//              @"zipcode" : self.zipcode
//            } mutableCopy];
}

- (NSMutableDictionary*)addValueToDictionary:(NSString*)value key:(NSString*)key dictionary:(NSMutableDictionary*)dictionary {
    if (value != nil)
        [dictionary setObject:value forKey:key];
    return dictionary;
}

//static id ObjectOrNull(id object) //TODO: delete this?
//{
//    return object ?: [NSNull null];
//}

@end
