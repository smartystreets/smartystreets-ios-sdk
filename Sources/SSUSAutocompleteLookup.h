#import <Foundation/Foundation.h>
#import "SSGeolocateType.h"
#import "SSUSAutocompleteSuggestion.h"
#import "SSUSAutocompleteResult.h"
#import "SSSmartyErrors.h"

@interface SSUSAutocompleteLookup : NSObject

@property (nonatomic) NSMutableArray<SSUSAutocompleteSuggestion*> *result;
@property (nonatomic) NSString *prefix;
@property (readonly, nonatomic) int maxSuggestions;
@property (nonatomic) NSMutableArray<NSString*> *cityFilter;
@property (nonatomic) NSMutableArray<NSString*> *stateFilter;
@property (nonatomic) NSMutableArray<NSString*> *prefer;
@property (nonatomic) SSGeolocateType *geolocateType;

- (instancetype)initWithPrefix:(NSString*)prefix;
- (void)addCityFilter:(NSString*)city;
- (void)addStateFilter:(NSString*)state;
- (void)addPrefer:(NSString*)cityOrState;
-(SSUSAutocompleteSuggestion*)getResultAtIndex:(int)index;
- (void)setMaxSuggestions:(int)maxSuggestions error:(NSError**)error;

@end
