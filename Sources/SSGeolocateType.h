#import <Foundation/Foundation.h>

extern NSString *const kSSGeolocateTypeCity;
extern NSString *const kSSGeolocateTypeState;
extern NSString *const kSSGeolocateTypeNone;

/*!
 @class SSGeolocateType
 
 @brief The Geolocate Type class
 
 @description This field corresponds to the <b>geolocate</b> and <b>geolocate_precision</b> fields in the US Autocomplete API.
 
 @see https://smartystreets.com/docs/cloud/us-autocomplete-api#http-request-input-fields
 */
@interface SSGeolocateType : NSObject

@property(readonly, nonatomic) NSString *name;

- (instancetype)initWithName:(NSString*)name;

@end
