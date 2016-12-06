#import <Foundation/Foundation.h>
#import "SSResult.h"
#import "SSLookup.h"

@interface SSZipCodeLookup : NSObject <SSLookup>

@property (nonatomic) SSResult *result;
@property (nonatomic) NSString *inputId;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zipcode;

- (instancetype)initWithZipcode:(NSString*)zipcode;
- (instancetype)initWithCity:(NSString*)city state:(NSString*)state;
- (instancetype)initWithCity:(NSString*)city state:(NSString*)state zipcode:(NSString*)zipcode;

@end
