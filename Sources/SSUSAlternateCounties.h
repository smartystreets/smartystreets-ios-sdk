#import <Foundation/Foundation.h>

/*!
 @class SSUSAlternateCounties
 
 @brief The US Alternate Counties class
 
 @see https://smartystreets.com/docs/cloud/us-zipcode-api#zipcodes
 */
@interface SSUSAlternateCounties : NSObject

@property (readonly, nonatomic) NSString *countyFips;
@property (readonly, nonatomic) NSString *countyName;
@property (readonly, nonatomic) NSString *stateAbbreviation;
@property (readonly, nonatomic) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
