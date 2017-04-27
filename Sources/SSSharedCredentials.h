#import <Foundation/Foundation.h>
#import "SSCredentials.h"

/*!
 @class SSSharedCredentials
 
 @brief The Shared Credentials Class
 
 @description Is useful if you want to use a website key.
 */
@interface SSSharedCredentials : NSObject <SSCredentials>

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *hostname;

- (instancetype)initWithId:(NSString*)id hostname:(NSString*)hostname;

@end
