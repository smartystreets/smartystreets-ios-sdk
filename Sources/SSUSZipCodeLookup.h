#import <Foundation/Foundation.h>
#import "SSUSZipCodeResult.h"
#import "SSLookup.h"

/*!
 @class SSUSZipCodeLookup
 
 @brief The US ZIPCode Lookup class
 
 @description In addition to holding all of the input data for this lookup, this class also will contain the result of the lookup after it comes back from the API.
 
 @see https://smartystreets.com/docs/cloud/us-zipcode-api#http-request-input-fields
 */
@interface SSUSZipCodeLookup : NSObject <SSLookup>

@property (nonatomic) SSUSZipCodeResult *result;
@property (nonatomic) NSString *inputId;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zipcode;

- (instancetype)initWithZipcode:(NSString*)zipcode;
- (instancetype)initWithCity:(NSString*)city state:(NSString*)state;
- (instancetype)initWithCity:(NSString*)city state:(NSString*)state zipcode:(NSString*)zipcode;

@end
