#import <Foundation/Foundation.h>
#import "SSUSCity.h"
#import "SSUSZipCode.h"

/*!
 @class SSUSZipCodeResult
 
 @brief The US ZIPCode Result class
 
 @see https://smartystreets.com/docs/cloud/us-zipcode-api#root
 */
@interface SSUSZipCodeResult : NSObject

/*! @brief this is set if there was no match*/
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *reason;
@property (readonly, nonatomic) int inputIndex;
@property (readonly, nonatomic) NSMutableArray<SSUSCity*> *cities;
@property (readonly, nonatomic) NSMutableArray<SSUSZipCode*> *zipCodes;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (bool)isValid;
- (SSUSCity*)getCityAtIndex:(int)index;
- (SSUSZipCode*)getZipCodeAtIndex:(int)index;

@end
