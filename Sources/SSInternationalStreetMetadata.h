#import <Foundation/Foundation.h>

@interface SSInternationalStreetMetadata : NSObject

@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic) NSString *geocodePrecision;
@property (readonly, nonatomic) NSString *maxGeocodePrecision;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
