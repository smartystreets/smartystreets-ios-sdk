#import <Foundation/Foundation.h>
#import "SSCredentials.h"

@interface SSSharedCredentials : NSObject <SSCredentials>

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *hostname;

- (instancetype)initWithId:(NSString*)id hostname:(NSString*)hostname;

@end
