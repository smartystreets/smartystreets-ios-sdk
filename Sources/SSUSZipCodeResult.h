#import <Foundation/Foundation.h>
#import "SSCity.h"
#import "SSUSZipCode.h"

@interface SSUSZipCodeResult : NSObject

@property (nonatomic) NSString *status;
@property (nonatomic) NSString *reason;
@property (readonly, nonatomic) int inputIndex;
@property (readonly, nonatomic) NSMutableArray<SSCity*> *cities;
@property (readonly, nonatomic) NSMutableArray<SSUSZipCode*> *zipCodes;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (bool)isValid;
- (SSCity*)getCityAtIndex:(int)index;
- (SSUSZipCode*)getZipCodeAtIndex:(int)index;

@end
