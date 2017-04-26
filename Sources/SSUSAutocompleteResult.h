#import <Foundation/Foundation.h>
#import "SSUSAutocompleteSuggestion.h"

/*!
 @class SSUSAutocompleteResult
 
 @brief The US Autocomplete Result class
 */
@interface SSUSAutocompleteResult : NSObject

@property (readonly, nonatomic) NSMutableArray<SSUSAutocompleteSuggestion*> *suggestions;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(SSUSAutocompleteSuggestion*)getSuggestionAtIndex:(int)index;

@end
