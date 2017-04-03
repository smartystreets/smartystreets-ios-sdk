#import <Foundation/Foundation.h>

@interface SSUSCity : NSObject

@property (readonly, nonatomic) NSString *city;
@property (readonly, nonatomic) bool mailableCity;
@property (readonly, nonatomic) NSString *stateAbbreviation;
@property (readonly, nonatomic) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
