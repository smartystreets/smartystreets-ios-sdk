#import "SSInternationalStreetComponents.h"

@implementation SSInternationalStreetComponents

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        _countryIso3 = dictionary[@"country_iso_3"];
        _superAdministrativeArea = dictionary[@"super_administrative_area"];
        _administrativeArea = dictionary[@"administrative_area"];
        _subAdministrativeArea = dictionary[@"sub_administrative_area"];
        _dependentLocality = dictionary[@"dependent_locality"];
        _dependentLocalityName = dictionary[@"dependent_locality_name"];
        _doubleDependentLocality = dictionary[@"double_dependent_locality"];
        _locality = dictionary[@"locality"];
        _postalCode = dictionary[@"postal_code"];
        _postalCodeShort = dictionary[@"postal_code_short"];
        _postalCodeExtra = dictionary[@"postal_code_extra"];
        _premise = dictionary[@"premise"];
        _premiseExtra = dictionary[@"premise_extra"];
        _premiseNumber = dictionary[@"premise_number"];
        _premisePrefixNumber = dictionary[@"premise_prefix_number"];
        _premiseType = dictionary[@"premise_type"];
        _thoroughfare = dictionary[@"thoroughfare"];
        _thoroughfarePredirection = dictionary[@"thoroughfare_predirection"];
        _thoroughfarePostdirection = dictionary[@"thoroughfare_postdirection"];
        _thoroughfareName = dictionary[@"thoroughfare_name"];
        _thoroughfareTrailingType = dictionary[@"thoroughfare_trailing_type"];
        _thoroughfareType = dictionary[@"thoroughfare_type"];
        _dependentThoroughfare = dictionary[@"dependent_thoroughfare"];
        _dependentThoroughfarePredirection = dictionary[@"dependent_thoroughfare_predirection"];
        _dependentThoroughfarePostdirection = dictionary[@"dependent_thoroughfare_postdirection"];
        _dependentThoroughfareName = dictionary[@"dependent_thoroughfare_name"];
        _dependentThoroughfareTrailingType = dictionary[@"dependent_thoroughfare_trailing_type"];
        _dependentThoroughfareType = dictionary[@"dependent_thoroughfare_type"];
        _building = dictionary[@"building"];
        _buildingLeadingType = dictionary[@"building_leading_type"];
        _buildingName = dictionary[@"building_name"];
        _buildingTrailingType = dictionary[@"building_trailing_type"];
        _subBuildingType = dictionary[@"sub_building_type"];
        _subBuildingNumber = dictionary[@"sub_building_number"];
        _subBuildingName = dictionary[@"sub_building_name"];
        _subBuilding = dictionary[@"sub_building"];
        _postBox = dictionary[@"post_box"];
        _postBoxType = dictionary[@"post_box_type"];
        _postBoxNumber = dictionary[@"post_box_number"];
    }
    return self;
}

@end
