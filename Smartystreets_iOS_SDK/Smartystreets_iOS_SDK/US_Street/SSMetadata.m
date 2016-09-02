#import "SSMetadata.h"

@interface SSMetadata()

@property (nonatomic) NSString *recordType;
@property (nonatomic) NSString *zipType;
@property (nonatomic) NSString *countyFips;
@property (nonatomic) NSString *countyName;
@property (nonatomic) NSString *carrierRoute;
@property (nonatomic) NSString *congressionalDistrict;
@property (nonatomic) NSString *buildingDefaultIndicator;
@property (nonatomic) NSString *rdi;
@property (nonatomic) NSString *elotSequence;
@property (nonatomic) NSString *elotSort;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSString *precision;
@property (nonatomic) NSString *timeZone;
@property (nonatomic) double utcOffset;
@property (nonatomic) bool obeysDst; //TODO: change the getter name from isObeysDst to obeysDst
@end

@implementation SSMetadata

@end
