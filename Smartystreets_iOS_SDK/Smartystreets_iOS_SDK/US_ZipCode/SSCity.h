#import <Foundation/Foundation.h>

@interface SSCity : NSObject

@property (readonly, nonatomic) NSString *city;
@property (readonly, nonatomic) bool mailableCity;
@property (readonly, nonatomic) NSString *stateAbbreviation;
@property (readonly, nonatomic) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
