#import <Foundation/Foundation.h>

@interface SSRequest : NSObject

@property (readonly, nonatomic) NSMutableDictionary *headers;
@property (readonly, nonatomic) NSMutableDictionary *parameters;
@property (readonly, nonatomic) NSString *method;
@property (nonatomic) NSMutableData *payload;

- (instancetype)initWithUrlPrefix:(NSString*)urlPrefix;
- (void)setValue:(NSString*)value forHTTPHeaderField:(NSString*)name;
- (void)setValue:(NSString*)value forHTTPParameterField:(NSString*)name;
- (NSString*)getUrl;

@end
