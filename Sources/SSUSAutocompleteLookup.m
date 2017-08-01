#import "SSUSAutocompleteLookup.h"

const int kSSMaxSuggestions = 10;
const double kSSPreferRatio = 1 / 3;

@implementation SSUSAutocompleteLookup

- (instancetype)init {
    if (self = [super init]) {
        _maxSuggestions = kSSMaxSuggestions;
        _cityFilter = [NSMutableArray<NSString*> new];
        _stateFilter = [NSMutableArray<NSString*> new];
        _prefer = [NSMutableArray<NSString*> new];
        _geolocateType = [[SSGeolocateType alloc] initWithName:kSSGeolocateTypeCity];
        _preferRatio = kSSPreferRatio;
    }
    return self;
}

- (instancetype)initWithPrefix:(NSString*)prefix {
    if (self = [[super self] init]) {
        _prefix = prefix;
    }
    return self;
}

-(SSUSAutocompleteSuggestion*)getResultAtIndex:(int)index {
    return [self.result objectAtIndex:index];
}

- (NSString*)GetMaxSuggestionsStringIfSet {
    if (self.maxSuggestions == kSSMaxSuggestions)
        return nil;
    return [NSString stringWithFormat:@"%d", self.maxSuggestions];
}

- (NSString*)GetPreferRatioStringIfSet {
    if (self.preferRatio == kSSPreferRatio)
        return nil;
    return [NSString stringWithFormat:@"%f", self.preferRatio];
}

- (void)setMaxSuggestions:(int)maxSuggestions error:(NSError**)error {
    if (self.maxSuggestions > 0 && self.maxSuggestions <= 10)
        _maxSuggestions = maxSuggestions;
    else {
        NSDictionary *details = @{NSLocalizedDescriptionKey: @"Max suggestions must be a positive integer no larger than 10."};
        *error = [NSError errorWithDomain:SSErrorDomain code:NotPositiveIntegerError userInfo:details];
    }
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

@end
