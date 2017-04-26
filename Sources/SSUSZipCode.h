#import <Foundation/Foundation.h>
#import "SSUSAlternateCounties.h"

/*!
 @class SSUSZipCode
 
 @brief The US ZIPCode class
 
 @see https://smartystreets.com/docs/cloud/us-zipcode-api#zipcodes
 */
@interface SSUSZipCode : NSObject

@property (readonly, nonatomic) NSString *zipCode;
@property (readonly, nonatomic) NSString *zipCodeType;
@property (readonly, nonatomic) NSString *defaultCity;
@property (readonly, nonatomic) NSString *countyFips;
@property (readonly, nonatomic) NSString *countyName;
@property (readonly, nonatomic) NSString *stateAbbreviation;
@property (readonly, nonatomic) NSString *state;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic) NSString *precision;
@property (readonly, nonatomic) NSMutableArray<SSUSAlternateCounties*> *alternateCounties;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (SSUSAlternateCounties*)getAlternateCountiesAtIndex:(int)index;

@end
