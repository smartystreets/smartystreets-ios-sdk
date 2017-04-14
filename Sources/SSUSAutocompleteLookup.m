#import "SSUSAutocompleteLookup.h"

@implementation SSUSAutocompleteLookup

- (instancetype)init {
    if (self = [super init]) {
        _maxSuggestions = 10;
        _cityFilter = [NSMutableArray<NSString*> new];
        _stateFilter = [NSMutableArray<NSString*> new];
        _prefer = [NSMutableArray<NSString*> new];
        _geolocateType = [[SSGeolocateType alloc] initWithName:kSSGeolocateTypeCity];
    }
    return self;
}

- (instancetype)initWithPrefix:(NSString*)prefix {
    if (self = [[super self] init]) {
        _prefix = prefix;
    }
    return self;
}

- (void)addCityFilter:(NSString*)city {
    [self.cityFilter addObject:city];
}

- (void)addStateFilter:(NSString*)state {
    [self.stateFilter addObject:state];
}

- (void)addPrefer:(NSString*)cityOrState {
    [self.prefer addObject:cityOrState];
}

-(SSUSAutocompleteSuggestion*)getResultAtIndex:(int)index {
    return [self.result objectAtIndex:index];
}

- (void)setMaxSuggestions:(int)maxSuggestions error:(NSError**)error {
    if (self.maxSuggestions > 0 && self.maxSuggestions <= 10)
        _maxSuggestions = maxSuggestions;
    else {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"Max suggestions must be a positive integer no larger than 10."};
        *error = [NSError errorWithDomain:SSErrorDomain code:NotPositiveIntegerError userInfo:details];
    }
}

@end
