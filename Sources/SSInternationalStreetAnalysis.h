#import <Foundation/Foundation.h>

@interface SSInternationalStreetAnalysis : NSObject

@property (readonly, nonatomic) NSString *verificationStatus;
@property (readonly, nonatomic) NSString *addressPrecision;
@property (readonly, nonatomic) NSString *maxAddressPrecision;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
