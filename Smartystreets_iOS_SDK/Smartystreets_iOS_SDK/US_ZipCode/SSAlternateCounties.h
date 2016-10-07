#import <Foundation/Foundation.h>

@interface SSAlternateCounties : NSObject

@property (readonly, nonatomic) NSString *countyFips;
@property (readonly, nonatomic) NSString *countyName;
@property (readonly, nonatomic) NSString *stateAbbreviation;
@property (readonly, nonatomic) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
