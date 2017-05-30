#import <Foundation/Foundation.h>

@interface SSSmartyResponse : NSObject

@property (nonatomic) NSInteger statusCode;
@property (nonatomic) NSData *payload;

- (instancetype)initWithStatusCode:(NSInteger)statusCode payload:(NSData*)payload;

@end
