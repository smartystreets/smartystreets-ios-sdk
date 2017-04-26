#import <Foundation/Foundation.h>

/*!
 @class SSUSCity
 
 @brief The US City class
 
 @description Known in the SmartyStreets US ZIP Code API documentation as a <b>city_state</b>
 
 @see https://smartystreets.com/docs/cloud/us-zipcode-api#cities
 */
@interface SSUSCity : NSObject

@property (readonly, nonatomic) NSString *city;
@property (readonly, nonatomic) bool mailableCity;
@property (readonly, nonatomic) NSString *stateAbbreviation;
@property (readonly, nonatomic) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
