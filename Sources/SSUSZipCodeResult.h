#import <Foundation/Foundation.h>
#import "SSUSCity.h"
#import "SSUSZipCode.h"

@interface SSUSZipCodeResult : NSObject

@property (nonatomic) NSString *status;
@property (nonatomic) NSString *reason;
@property (readonly, nonatomic) int inputIndex;
@property (readonly, nonatomic) NSMutableArray<SSUSCity*> *cities;
@property (readonly, nonatomic) NSMutableArray<SSUSZipCode*> *zipCodes;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (bool)isValid;
- (SSUSCity*)getCityAtIndex:(int)index;
- (SSUSZipCode*)getZipCodeAtIndex:(int)index;

@end
