#import <Foundation/Foundation.h>
#import "SSCity.h"
#import "SSZipCode.h"

@interface SSResult : NSObject

@property (readonly, nonatomic) NSString *status;
@property (readonly, nonatomic) NSString *reason;
@property (readonly, nonatomic) int inputIndex;
@property (readonly, nonatomic) NSMutableArray<SSCity*> *cities;
@property (readonly, nonatomic) NSMutableArray<SSZipCode*> *zipCodes;

- (bool)isValid;
- (SSCity*)getCity:(int)index;
- (SSZipCode*)getZipCode:(int)index;

@end
