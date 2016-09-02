#import <Foundation/Foundation.h>
#import "SSCity.h"
#import "SSZipCode.h"

@interface SSResult : NSObject

@property (nonatomic) NSString *status;
@property (nonatomic) NSString *reason;

- (bool)isValid;
- (SSCity*)getCity:(int)index;
- (SSZipCode*)getZipCode:(int)index;

@end
