#import "SSUSStreetLookup.h"

NSString *const kSSStrict = @"strict";
NSString *const kSSRange = @"range";
NSString *const kSSInvalid = @"invalid";

@implementation SSUSStreetLookup

- (instancetype)init {
    if (self = [super init]) {
        _maxCandidates = 1;
        _result = [[NSMutableArray<SSUSStreetCandidate*> alloc] init];
    }
    return self;
}

- (instancetype)initWithFreeformAddress:(NSString*)freeformAddress {
    if (self = [[super self] init])
        _street = freeformAddress;
    return self;
}

- (void)addToResult:(SSUSStreetCandidate*)newCandidate {
    [self.result addObject:newCandidate];
}

- (SSUSStreetCandidate*)getResultAtIndex:(int)index {
    return [self.result objectAtIndex:index];
}

- (void)setMaxCandidates:(int)maxCandidates error:(NSError**)error {
    if (maxCandidates > 0)
        _maxCandidates = maxCandidates;
    else {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"Max candidates must be a positive integer."};
        *error = [NSError errorWithDomain:SSErrorDomain code:NotPositiveIntegerError userInfo:details]; 
    }
}

- (NSDictionary*)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    dictionary = [self addValueToDictionary:self.street key:@"street" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.street2 key:@"street2" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.secondary key:@"secondary" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.city key:@"city" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.state key:@"state" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.zipCode key:@"zipcode" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.lastline key:@"lastline" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.addressee key:@"addressee" dictionary:dictionary];
    dictionary = [self addValueToDictionary:self.urbanization key:@"urbanization" dictionary:dictionary];
    [dictionary setObject:[NSNumber numberWithInteger:self.maxCandidates] forKey:@"candidates"];
    dictionary = [self addValueToDictionary:self.matchStrategy key:@"match" dictionary:dictionary];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (NSMutableDictionary*)addValueToDictionary:(NSString*)value key:(NSString*)key dictionary:(NSMutableDictionary*)dictionary {
    if (value != nil)
        [dictionary setObject:value forKey:key];
    return dictionary;
}

@end
