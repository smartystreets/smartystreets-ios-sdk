#import <Foundation/Foundation.h>

/*!
 @class SSInternationalStreetComponents
 
 @brief The International Street Components class
 
 @see https://smartystreets.com/docs/cloud/international-street-api#components
 */
@interface SSInternationalStreetComponents : NSObject

@property (readonly, nonatomic) NSString *countryIso3;
@property (readonly, nonatomic) NSString *superAdministrativeArea;
@property (readonly, nonatomic) NSString *administrativeArea;
@property (readonly, nonatomic) NSString *subAdministrativeArea;
@property (readonly, nonatomic) NSString *dependentLocality;
@property (readonly, nonatomic) NSString *dependentLocalityName;
@property (readonly, nonatomic) NSString *doubleDependentLocality;
@property (readonly, nonatomic) NSString *locality;
@property (readonly, nonatomic) NSString *postalCode;
@property (readonly, nonatomic) NSString *postalCodeShort;
@property (readonly, nonatomic) NSString *postalCodeExtra;
@property (readonly, nonatomic) NSString *premise;
@property (readonly, nonatomic) NSString *premiseExtra;
@property (readonly, nonatomic) NSString *premiseNumber;
@property (readonly, nonatomic) NSString *premisePrefixNumber;
@property (readonly, nonatomic) NSString *premiseType;
@property (readonly, nonatomic) NSString *thoroughfare;
@property (readonly, nonatomic) NSString *thoroughfarePredirection;
@property (readonly, nonatomic) NSString *thoroughfarePostdirection;
@property (readonly, nonatomic) NSString *thoroughfareName;
@property (readonly, nonatomic) NSString *thoroughfareTrailingType;
@property (readonly, nonatomic) NSString *thoroughfareType;
@property (readonly, nonatomic) NSString *dependentThoroughfare;
@property (readonly, nonatomic) NSString *dependentThoroughfarePredirection;
@property (readonly, nonatomic) NSString *dependentThoroughfarePostdirection;
@property (readonly, nonatomic) NSString *dependentThoroughfareName;
@property (readonly, nonatomic) NSString *dependentThoroughfareTrailingType;
@property (readonly, nonatomic) NSString *dependentThoroughfareType;
@property (readonly, nonatomic) NSString *building;
@property (readonly, nonatomic) NSString *buildingLeadingType;
@property (readonly, nonatomic) NSString *buildingName;
@property (readonly, nonatomic) NSString *buildingTrailingType;
@property (readonly, nonatomic) NSString *subBuildingType;
@property (readonly, nonatomic) NSString *subBuildingNumber;
@property (readonly, nonatomic) NSString *subBuildingName;
@property (readonly, nonatomic) NSString *subBuilding;
@property (readonly, nonatomic) NSString *postBox;
@property (readonly, nonatomic) NSString *postBoxType;
@property (readonly, nonatomic) NSString *postBoxNumber;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
