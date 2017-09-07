#import <Foundation/Foundation.h>

/*!
 @class SSInternationalStreetMetadata
 
 @brief The international Street Metadata class
 
 @see https://smartystreets.com/docs/cloud/international-street-api#metadata
 */
@interface SSInternationalStreetMetadata : NSObject

@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic) NSString *geocodePrecision;
@property (readonly, nonatomic) NSString *maxGeocodePrecision;
@property (readonly, nonatomic) NSString *addressFormat;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
