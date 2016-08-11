#import <Foundation/Foundation.h>

@interface SSResponse : NSObject

@property (nonatomic) NSInteger statusCode;
@property (nonatomic) NSMutableData *payload;

- (instancetype)initWithStatusCode:(NSInteger)statusCode payload:(NSMutableData*)payload;

@end
