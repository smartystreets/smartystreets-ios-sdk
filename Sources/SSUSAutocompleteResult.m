#import "SSUSAutocompleteResult.h"

@implementation SSUSAutocompleteResult

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _suggestions = dictionary[@"suggestions"];
        
        if ([self.suggestions isEqual:[NSNull null]])
            _suggestions = [NSMutableArray<SSUSAutocompleteSuggestion*> new];
        
        _suggestions = [self convertToSuggestionObjects];
    }
    return self;
}

- (NSMutableArray<SSUSAutocompleteSuggestion*>*)convertToSuggestionObjects {
    NSMutableArray<SSUSAutocompleteSuggestion*> *suggestionObjects = [NSMutableArray<SSUSAutocompleteSuggestion*> new];
    
    for (NSDictionary *suggestion in self.suggestions) {
        [suggestionObjects addObject:[[SSUSAutocompleteSuggestion alloc] initWithDictionary:suggestion]];
    }
    return suggestionObjects;
}

- (SSUSAutocompleteSuggestion*)getSuggestionAtIndex:(int)index {
    return [self.suggestions objectAtIndex:index];
}

@end
