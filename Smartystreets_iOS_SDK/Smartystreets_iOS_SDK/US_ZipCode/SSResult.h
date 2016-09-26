#import <Foundation/Foundation.h>
#import "SSCity.h"
#import "SSZipCode.h"

@interface SSResult : NSObject

@property (nonatomic) NSString *status;
@property (nonatomic) NSString *reason;
@property (readonly, nonatomic) int inputIndex;
@property (readonly, nonatomic) NSMutableArray<SSCity*> *cities;
@property (readonly, nonatomic) NSMutableArray<SSZipCode*> *zipCodes;

- (instancetype)initWithData:(NSDictionary*)data;
- (bool)isValid;
- (SSCity*)getCity:(int)index;
- (SSZipCode*)getZipCode:(int)index;

@end
