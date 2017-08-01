#import <Foundation/Foundation.h>
#import "SSGeolocateType.h"
#import "SSUSAutocompleteSuggestion.h"
#import "SSUSAutocompleteResult.h"
#import "SSSmartyErrors.h"

/*!
 @class SSUSAutocompleteLookup
 
 @brief The US Autocomplete Lookup class
 
 @description In addition to holding all of the input data for this lookup, this class also<br> will contain the result of the lookup after it comes back from the API.
 
 @see https://smartystreets.com/docs/cloud/us-autocomplete-api#http-request-input-fields
 */
@interface SSUSAutocompleteLookup : NSObject

@property (nonatomic) NSMutableArray<SSUSAutocompleteSuggestion*> *result;
@property (nonatomic) NSString *prefix;
@property (readonly, nonatomic) int maxSuggestions;
@property (nonatomic) NSMutableArray<NSString*> *cityFilter;
@property (nonatomic) NSMutableArray<NSString*> *stateFilter;
@property (nonatomic) NSMutableArray<NSString*> *prefer;
@property (nonatomic) SSGeolocateType *geolocateType;
@property (nonatomic) double preferRatio;

/*!
 @param prefix The beginning of an address
 */
- (instancetype)initWithPrefix:(NSString*)prefix;
- (void)addCityFilter:(NSString*)city;
- (void)addStateFilter:(NSString*)state;
- (void)addPrefer:(NSString*)cityOrState;
- (SSUSAutocompleteSuggestion*)getResultAtIndex:(int)index;
- (void)setMaxSuggestions:(int)maxSuggestions error:(NSError**)error;
- (NSString*)GetMaxSuggestionsStringIfSet;
- (NSString*)GetPreferRatioStringIfSet;

@end
