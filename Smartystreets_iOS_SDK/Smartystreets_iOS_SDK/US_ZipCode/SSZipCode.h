#import <Foundation/Foundation.h>

@interface SSZipCode : NSObject

@property (readonly, nonatomic) NSString *zipCode;
@property (readonly, nonatomic) NSString *zipCodeType;
@property (readonly, nonatomic) NSString *defaultCity;
@property (readonly, nonatomic) NSString *countyFips;
@property (readonly, nonatomic) NSString *countyName;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic) NSString *precision;

- (instancetype)initWithData:(NSDictionary*)data;

@end
