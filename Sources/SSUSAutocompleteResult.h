#import <Foundation/Foundation.h>
#import "SSUSAutocompleteSuggestion.h"

@interface SSUSAutocompleteResult : NSObject

@property (readonly, nonatomic) NSMutableArray<SSUSAutocompleteSuggestion*> *suggestions;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(SSUSAutocompleteSuggestion*)getSuggestionAtIndex:(int)index;

@end
