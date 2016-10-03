#import <Foundation/Foundation.h>
#include "SSAlternateCounties.h"

@interface SSZipCode : NSObject

@property (readonly, nonatomic) NSString *zipCode;
@property (readonly, nonatomic) NSString *zipCodeType;
@property (readonly, nonatomic) NSString *defaultCity;
@property (readonly, nonatomic) NSString *countyFips;
@property (readonly, nonatomic) NSString *countyName;
@property (readonly, nonatomic) NSString *stateAbbreviation;
@property (readonly, nonatomic) NSString *state;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic) NSString *precision;
@property (readonly, nonatomic) NSMutableArray<SSAlternateCounties*> *alternateCounties;

- (instancetype)initWithData:(NSDictionary*)data;
- (SSAlternateCounties*)getAlternateCountiesAtIndex:(int)index;

@end
