#import <Foundation/Foundation.h>

@interface SSUSStreetMetadata : NSObject

@property (readonly, nonatomic) NSString *recordType;
@property (readonly, nonatomic) NSString *zipType;
@property (readonly, nonatomic) NSString *countyFips;
@property (readonly, nonatomic) NSString *countyName;
@property (readonly, nonatomic) NSString *carrierRoute;
@property (readonly, nonatomic) NSString *congressionalDistrict;
@property (readonly, nonatomic) NSString *buildingDefaultIndicator;
@property (readonly, nonatomic) NSString *rdi;
@property (readonly, nonatomic) NSString *elotSequence;
@property (readonly, nonatomic) NSString *elotSort;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic) NSString *precision;
@property (readonly, nonatomic) NSString *timeZone;
@property (readonly, nonatomic) double utcOffset;
@property (readonly, nonatomic) bool obeysDst;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
