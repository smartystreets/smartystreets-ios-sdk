#import <Foundation/Foundation.h>

@interface SSSmartyRequest : NSObject

@property (readonly, nonatomic) NSMutableDictionary *headers;
@property (readonly, nonatomic) NSMutableDictionary *parameters;
@property (nonatomic) NSString *urlPrefix;
@property (nonatomic) NSData *payload;
@property (nonatomic) NSString *referer;
@property (readonly, nonatomic) NSString *method;
@property (nonatomic) NSString *contentType;

- (void)setValue:(NSString*)value forHTTPHeaderField:(NSString*)name;
- (void)setValue:(NSString*)value forHTTPParameterField:(NSString*)name;
- (NSString*)getUrl;

@end
