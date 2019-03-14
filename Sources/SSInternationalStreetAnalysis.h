#import <Foundation/Foundation.h>
#import "SSInternationalStreetChanges.h"

/*!
 @class SSInternationalStreetAnalysis
 
 @brief The International Street Analysis class
 
 @see https://smartystreets.com/docs/cloud/international-street-api#analysis
 */
@interface SSInternationalStreetAnalysis : NSObject

@property (readonly, nonatomic) NSString *verificationStatus;
@property (readonly, nonatomic) NSString *addressPrecision;
@property (readonly, nonatomic) NSString *maxAddressPrecision;
@property (readonly, nonatomic) SSInternationalStreetChanges *changes;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
