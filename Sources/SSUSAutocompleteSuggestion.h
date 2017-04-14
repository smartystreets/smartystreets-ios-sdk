#import <Foundation/Foundation.h>

@interface SSUSAutocompleteSuggestion : NSObject

@property (readonly, nonatomic) NSString *text;
@property (readonly, nonatomic) NSString *streetLine;
@property (readonly, nonatomic) NSString *city;
@property (readonly, nonatomic) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
