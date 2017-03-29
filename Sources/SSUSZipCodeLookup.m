#import "SSUSZipCodeLookup.h"

@implementation SSUSZipCodeLookup

- (instancetype)init {
    if (self = [super init])
        _result = [[SSUSZipCodeResult alloc] init];
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
    
    dictionary = [self addValueToDictionary:self.city key:@"city" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.state key:@"state" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.zipcode key:@"zipcode" dictionary:dictionary];
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (NSMutableDictionary*)addValueToDictionary:(NSString*)value key:(NSString*)key dictionary:(NSMutableDictionary*)dictionary {
    if (value != nil)
        [dictionary setObject:value forKey:key];
    return dictionary;
}

@end
