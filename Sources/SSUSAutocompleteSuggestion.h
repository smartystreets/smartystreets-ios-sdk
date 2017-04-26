#import <Foundation/Foundation.h>

/*!
 @class SSUSAutocompleteSuggestion
 
 @brief The US Autocomplete Suggestion class
 
 @see https://smartystreets.com/docs/cloud/us-autocomplete-api#http-response
 */
@interface SSUSAutocompleteSuggestion : NSObject

@property (readonly, nonatomic) NSString *text;
@property (readonly, nonatomic) NSString *streetLine;
@property (readonly, nonatomic) NSString *city;
@property (readonly, nonatomic) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
