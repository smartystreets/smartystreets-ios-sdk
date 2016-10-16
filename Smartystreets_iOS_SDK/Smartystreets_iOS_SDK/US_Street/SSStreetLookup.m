#import "SSStreetLookup.h"

@implementation SSStreetLookup

- (instancetype)init {
    if (self = [super init]) {
        _maxCandidates = 1;
        _result = [[NSMutableArray<SSCandidate*> alloc] init];
    }
    return self;
}

- (instancetype)initWithFreeformAddress:(NSString*)freeformAddress {
    if (self = [[super self] init])
        _street = freeformAddress;
    return self;
}

- (void)addToResult:(SSCandidate*)newCandidate {
    [self.result addObject:newCandidate];
}

- (SSCandidate*)getResultAtIndex:(int)index {
    return [self.result objectAtIndex:index];
}

- (void)setMaxCandidates:(int)maxCandidates error:(NSError**)error {
    if (maxCandidates > 0)
        _maxCandidates = maxCandidates;
    
    NSDictionary *details = @{NSLocalizedDescriptionKey: @"Max candidates must be a positive integer."};
    *error = [NSError errorWithDomain:NSCocoaErrorDomain code:nil userInfo:details]; //TODO: what is the error code?
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
//    dictionary = [self addValueToDictionary:self.match key:@"match" dictionary:dictionary];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (NSMutableDictionary*)addValueToDictionary:(NSString*)value key:(NSString*)key dictionary:(NSMutableDictionary*)dictionary {
    if (value != nil)
        [dictionary setObject:value forKey:key];
    return dictionary;
}

@end
